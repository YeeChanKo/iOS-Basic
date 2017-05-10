//
//  DetailViewController.m
//  week9
//
//  Created by viz on 2017. 5. 10..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController{
    NSURLSession *session;
    NSURLSessionStreamTask *streamTask;
    NSInputStream *inputStream;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    [self startConnection];
    
    // will resign active
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    // will assign active
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillAssignActive) name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self stopConnection];
}

-(void)appWillResignActive{
    [self stopConnection];
}

-(void)appWillAssignActive{
    [self startConnection];
}

-(void)startConnection{
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                            delegate:self delegateQueue:nil];
    streamTask = [session streamTaskWithHostName:@"127.0.0.1" port:8000];
    [streamTask resume]; // start the task
    [streamTask startSecureConnection]; // flush & establish secure connection
    [streamTask captureStreams]; // flush & capture & call delegate method
}

-(void)stopConnection{
    [inputStream close];
    [streamTask stopSecureConnection];
    [streamTask cancel];
    [session invalidateAndCancel];
}

- (void)URLSession:(NSURLSession *)session
        streamTask:(NSURLSessionStreamTask *)streamTask
didBecomeInputStream:(NSInputStream *)aInputStream
      outputStream:(NSOutputStream *)outputStream{
    
    inputStream = aInputStream; // save reference
    [inputStream setDelegate:self]; // set nsstream delegate receiver
    [inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode]; // schedule stream on run loop
    [inputStream open]; // open input stream
}

// only invoked again when the stream is read
-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    NSLog(@"NSStreamEventCode: %lu", eventCode);
    if(eventCode == NSStreamEventHasBytesAvailable){
        NSInputStream *stream = (NSInputStream*)aStream; // convert to input stream
        
        // read size flag
        int byteOfSizeFlag = 8;
        uint8_t *sizeFlag = malloc(byteOfSizeFlag * sizeof(uint8_t));
        NSInteger byteRead = [stream read:sizeFlag maxLength:byteOfSizeFlag];
        if(byteRead == 0){
            return;
        }
        NSString *sizeFlagString = [[NSString alloc] initWithBytes:sizeFlag
                                                            length:byteOfSizeFlag
                                                          encoding:NSUTF8StringEncoding];
        NSLog(@"%@", sizeFlagString);
        
        // read main content
        int byteOfContent = [sizeFlagString intValue];
        uint8_t *content = malloc(byteOfContent * sizeof(uint8_t));
        NSInteger byteRead2 = [stream read:content maxLength:byteOfContent];
        if(byteRead2 == 0){
            return;
        }
        NSData *imageData = [NSData dataWithBytes:content length:byteOfContent];
        UIImage *image = [UIImage imageWithData:imageData];
        
        // set image
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _screenImage.image = image;
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

#pragma mark - Managing the detail item
- (void)setDetailItem:(NSDate *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

@end
