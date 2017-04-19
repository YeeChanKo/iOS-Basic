//
//  CardDeck.h
//  week6
//
//  Created by viz on 2017. 4. 19..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDeck : NSObject

@property NSMutableArray* cardDeck;

-(void)randomize;

@end
