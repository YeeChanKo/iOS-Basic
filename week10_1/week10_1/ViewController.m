//
//  ViewController.m
//  week10_1
//
//  Created by viz on 2017. 5. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@end

@implementation ViewController{
    NSString *bookText;
    NSMutableDictionary *countDic;
    NSOperationQueue *queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupConcurruentOperationQueueWithMaxCount:20];
    countDic = [[NSMutableDictionary alloc] init];
    bookText = [self readStringFromBookText];
    [self downloadWordList];
}

-(int)getTotalCountOfOccuredWordInDic:(NSDictionary*)dic{
    int total = 0;
    NSArray *keys = [dic allKeys];
    for (NSString *key in keys) {
        int countOfWord = [[dic objectForKey:key] intValue];
        total += countOfWord;
    }
    return total;
}

-(void)downloadWordList{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    [[session downloadTaskWithURL:[NSURL URLWithString:@"http://125.209.194.123/wordlist.php"]] resume];
}

-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSArray *wordList = [self getArrayFromJsonFileURL:location];
    
    [wordList enumerateObjectsUsingBlock:^(NSString *word, NSUInteger idx, BOOL *stop) {
        __weak typeof(self) weakSelf = self;
        [weakSelf addConcurruentOperation:^{
            [weakSelf countWord:word inText:bookText AndAddToDic:countDic];
        }];
    }];
    
    [self startConcurrentOperationQueue];
    [queue waitUntilAllOperationsAreFinished];
    
    NSArray *sortedKeys = [self sortedKeysOfDicByCountOnAscendingOrder:countDic];
    NSString *message = [self makeMessageFromSortedResult:countDic :sortedKeys];
    
    int totalCount = [self getTotalCountOfOccuredWordInDic:countDic];
    
    [self showAlertWithTitle:@"결과" message:[NSString stringWithFormat:@"%@\n총 개수 합계 : %d", message, totalCount]];
}

-(void)startConcurrentOperationQueue{
    [queue setSuspended:NO];
}

-(void)setupConcurruentOperationQueueWithMaxCount:(int)count{
    queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:count];
    [queue setSuspended:YES];
}

-(void)addConcurruentOperation:(void (^)())block{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:block];
    [queue addOperation:op];
}

-(void)countWord:(NSString*)wordToCount inText:(NSString*)text AndAddToDic:(NSDictionary*)dic{
    NSUInteger count = [self countOfSubstring:wordToCount atContents:text];
    [countDic setObject:@(count) forKey:wordToCount];
}

-(NSArray*)getArrayFromJsonFileURL:(NSURL*)location{
    NSString *jsonString = [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:0 error:nil];
    return array;
}

-(NSString*)makeMessageFromSortedResult:(NSDictionary*)dic :(NSArray*)keys{
    NSString *keyForMost = [keys objectAtIndex:([keys count] - 1)];
    NSString *keyForLeast = [keys objectAtIndex:0];
    NSNumber *mostCount = [dic objectForKey:keyForMost];
    NSNumber *leastCount = [dic objectForKey:keyForLeast];
    NSString *message = [NSString stringWithFormat:@"가장 많은 단어 - %@ : %@\n가장 적은 단어 - %@ : %@",
                         keyForMost, mostCount, keyForLeast, leastCount];
    return message;
}

-(NSArray*)sortedKeysOfDicByCountOnAscendingOrder:(NSDictionary*)dic{
    return [dic keysSortedByValueUsingComparator:^NSComparisonResult(NSNumber *number1, NSNumber *number2) {
        return [number1 compare:number2];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)readStringFromBookText{
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    return bookfile;
}

-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message {
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}


-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:substring
                                  options:NSRegularExpressionIgnoreMetacharacters
                                  error:nil];
    return [regex numberOfMatchesInString:contents options:0 range:NSMakeRange(0, [contents length])];
}

@end
