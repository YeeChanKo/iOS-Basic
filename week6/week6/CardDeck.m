//
//  CardDeck.m
//  week6
//
//  Created by viz on 2017. 4. 19..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "CardDeck.h"

@implementation CardDeck

-(void)randomize
{
    int card1 = [CardDeck randomCardIndexNum];
    int card2;
    do {
        card2 = [CardDeck randomCardIndexNum];
    } while (card2 == card1);
    int card3;
    do {
        card3 = [CardDeck randomCardIndexNum];
    } while (card3 == card1 || card3 == card2);
    
    NSString *cardName1 = [_cardDeck objectAtIndex:card1];
    NSString *cardName2 = [_cardDeck objectAtIndex:card2];
    NSString *cardName3 = [_cardDeck objectAtIndex:card3];
    
    // setter 형식으로 불러야 observer가 콜이 된다
    self.randomCards = [[NSMutableArray alloc] initWithObjects:cardName1, cardName2, cardName3, nil];
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjects:randomCards forKeys:[NSArray arrayWithObjects:@"1",@"2",@"3", nil]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"randomized" object:nil userInfo:dic];
}

+(int)randomCardIndexNum
{
    return arc4random() % 52;
}

@end
