//
//  CardView.m
//  week5
//
//  Created by viz on 2017. 4. 12..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "CardView.h"

#define CARD_WIDTH 130
#define CARD_HEIGHT 150
#define PADDING_LEFT 26
#define PADDING_TOP_STACK 100
#define PADDING_TOP_BOTTOM 500
#define CARD_SPACING_WIDTH_STACK 10
#define CARD_SPACING_WIDTH_BOTTOM 24
#define CARD_SPACING_HEIGHT_STACK 40
#define REFRESH_ICON_WIDTH 80
#define REFRESH_ICON_PADDING 100

@implementation CardView
{
    NSMutableDictionary *cardImages;
    NSMutableArray *cardImageDicKeys;
    int deviceMaxX;
    int deviceMaxY;
    UIImageView *refreshButton;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // generate and insert card uiimages to nsdictionary with each file name used as key
    cardImages = [[NSMutableDictionary alloc] init];
    [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"card_decks"] enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL *stop) {
        UIImage* cardImage = [self changeDimensions:[UIImage imageWithContentsOfFile:path]
                                                   :CARD_WIDTH :CARD_HEIGHT]; // autorelease
        [cardImages setObject:cardImage forKey:[path lastPathComponent]];
    }];
    cardImageDicKeys = [[NSMutableArray alloc] initWithArray:[cardImages allKeys]]; // permanent
    
    // get device info
    deviceMaxX = CGRectGetMaxX(self.bounds);
    deviceMaxY = CGRectGetMaxY(self.bounds);
    
    // set up refresh button - display, animate
    [self refreshButtonSetup];
}

-(void)displayCards
{
    NSArray *keys = cardImageDicKeys; // refer to nsarray
    NSString *aKey = nil;
    int count = 0;
    
    // stack cards display
    for(int i = 0; i<7; i++){
        for(int j = 0; j <= i; j++){
            aKey = [keys objectAtIndex:count]; // reference from nsarray
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:[self makeRectOfCardAtStack:i :j]];
            imgView.image = [cardImages objectForKey:aKey]; // reference from dic
            [self addSubview:imgView];
            count++;
            
            [imgView release];
        }
    }
    
    int bottomStart = count;
    
    // bottom cards display
    for(; count < [keys count]; count++){
        aKey = [keys objectAtIndex:count]; // reference from nsarray
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:[self makeRectOfCardAtBottom:count-bottomStart]];
        imgView.image = [cardImages objectForKey:aKey]; // reference from dic
        [self addSubview:imgView];
        
        [imgView release];
    }
}

- (void)drawRect:(CGRect)rect
{
    [self displayCards];
}

-(void)refreshButtonTouched
{
    // execute animation
    [self refreshButtonAnimation];
}

-(void)refreshButtonAnimation
{
    CABasicAnimation *rotate;
    rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"]; // autorelease
    rotate.fromValue = [NSNumber numberWithFloat:0]; // autorelease
    rotate.toValue = [NSNumber numberWithFloat:[self deg2rad:360]]; // autorelease
    rotate.duration = 0.25;
    rotate.repeatCount = 1;
    rotate.delegate = self;
    [refreshButton.layer addAnimation:rotate forKey:@"10"];
}

// callback from animation
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // shuffle nsarray
    [self shuffleCards];
    [self setNeedsDisplay];
}

-(void)shuffleCards
{
    // the Knuth shuffle
    // nsinteger is a typedef for primitive, no need to be released
    for (NSInteger i = cardImageDicKeys.count-1; i > 0; i--)
    {
        [cardImageDicKeys exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int)i+1)];
    }
}

-(void)refreshButtonSetup
{
    // refresh button display
    refreshButton = [[UIImageView alloc] initWithFrame:CGRectMake(deviceMaxX-REFRESH_ICON_PADDING, deviceMaxY-REFRESH_ICON_PADDING, REFRESH_ICON_WIDTH, REFRESH_ICON_WIDTH)];
    refreshButton.image = [self changeDimensions:[UIImage imageNamed:@"refresh.png"] :REFRESH_ICON_WIDTH :REFRESH_ICON_WIDTH];
    
    // add refreshbutton's layer as sublayer for animation
    [[self layer] addSublayer:[refreshButton layer]];
    
    // add animation on refresh button
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshButtonTouched)];
    singleTap.numberOfTapsRequired = 1;
    [refreshButton setUserInteractionEnabled:YES];
    [refreshButton addGestureRecognizer:singleTap];
}

-(float)deg2rad:(int)degree
{
    return (double)degree * M_PI / 180;
}

-(CGRect)makeRectOfCardAtStack:(int)arrayCount :(int)stackCount
{
    return CGRectMake(PADDING_LEFT + arrayCount * (CARD_SPACING_WIDTH_STACK + CARD_WIDTH),
                      PADDING_TOP_STACK + stackCount * CARD_SPACING_HEIGHT_STACK,
                      CARD_WIDTH, CARD_HEIGHT);
}

-(CGRect)makeRectOfCardAtBottom:(int)count
{
    return CGRectMake(PADDING_LEFT + count * CARD_SPACING_WIDTH_BOTTOM,
                      PADDING_TOP_BOTTOM, CARD_WIDTH, CARD_HEIGHT);
}

-(UIImage*)changeDimensions:(UIImage*)image :(int)targetWidth :(int)targetHeight
{
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, targetHeight);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, targetWidth, targetHeight), [image CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
