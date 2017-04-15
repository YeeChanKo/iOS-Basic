//
//  CardDeck.h
//  week5
//
//  Created by viz on 2017. 4. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject

@property(retain) NSMutableArray* cardDeck;

- (instancetype)init;
-(void)shuffleCards;

@end
