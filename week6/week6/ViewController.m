//
//  ViewController.m
//  week6
//
//  Created by viz on 2017. 4. 19..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "ViewController.h"
#import "CardView.h"
#import "CardDeck.h"

@interface ViewController ()

@end

@implementation ViewController {
    CardView *cardView;
    CardDeck *cardDeck;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        [cardDeck randomize];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cardView = [[CardView alloc] init];
    cardDeck = [[CardDeck alloc] init];
    
    cardDeck.cardDeck = [[NSMutableArray alloc] initWithArray:[cardView.cardImages allKeys]];
    
    [cardDeck addObserver:self
               forKeyPath:@"randomCards"
                  options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                  context:NULL];
    
    //    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    //    [notiCenter addObserver:self selector:@selector(displayRandomCards:) name:@"randomized" object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqual:@"randomCards"]) {
        // object가 observer가 바인딩되었던 객체
        NSMutableArray* randomCards = ((CardDeck*)object).randomCards;
        
        for(int i = 0; i < [randomCards count]; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:[self makeRectOfCardWithNum:i]];
            imgView.image = [cardView.cardImages objectForKey:randomCards[i]];
            [self.view addSubview:imgView];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomButtonTouched:(id)sender {
    [cardDeck randomize];
}

-(void)displayRandomCards:(NSNotification*)noti {
    NSDictionary *dic = [noti userInfo];
    NSLog(@"%@", dic);
    
    for (NSString* key in dic) {
        NSString *value = [dic objectForKey:key];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:[self makeRectOfCardWithNum:[key intValue]]];
        
        imgView.image = [cardView.cardImages objectForKey:value];
        [self.view addSubview:imgView];
    }
}

-(CGRect)makeRectOfCardWithNum:(int)num {
    return CGRectMake(150+150*num, 300, CARD_WIDTH, CARD_HEIGHT);
}

@end
