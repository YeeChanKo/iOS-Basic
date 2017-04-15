//
//  CardView.m
//  week5
//
//  Created by viz on 2017. 4. 12..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "CardView.h"

#import "StaticUtils.h"

@implementation CardView
{
    NSMutableArray* _cardDeck; // refer to carddeck in cardview
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // generate and insert card uiimages to nsdictionary with each file name used as key
    _cardImages = [[NSMutableDictionary alloc] init];
    [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"card_decks"] enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL *stop) {
        
        UIImage* cardImage = [StaticUtils changeDimensions:[UIImage imageWithContentsOfFile:path] :CARD_WIDTH :CARD_HEIGHT]; // autorelease
        [_cardImages setObject:cardImage forKey:[path lastPathComponent]];
    }]; // permanent
}

-(void)initializeCardDeckReference:(NSMutableArray*)cardDeck
{
    _cardDeck = cardDeck;
}

-(void)drawRect:(CGRect)rect
{
    [self displayCard];
}

-(void)displayCard
{
    NSArray *keys = _cardDeck; // reference
    NSString *aKey = nil; // not assigned, will reference
    int count = 0;
    
    // stack cards display
    for(int i = 0; i<7; i++){
        for(int j = 0; j <= i; j++){
            aKey = [keys objectAtIndex:count]; // reference from nsarray
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:[self makeRectOfCardAtStack:i :j]];
            imgView.image = [_cardImages objectForKey:aKey]; // reference from dic
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
        imgView.image = [_cardImages objectForKey:aKey]; // reference from dic
        [self addSubview:imgView];
        
        [imgView release];
    }
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

@end
