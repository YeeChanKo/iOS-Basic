//
//  CardDeck.m
//  week5
//
//  Created by viz on 2017. 4. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "CardModel.h"

@implementation CardModel

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    // write your initialization code
    return self;
}

-(void)shuffleCards
{
    // the Knuth shuffle
    // nsinteger is a typedef for primitive, no need to be released
    for (NSInteger i = _cardDeck.count-1; i > 0; i--)
    {
        [_cardDeck exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int)i+1)];
    }
}

@end
