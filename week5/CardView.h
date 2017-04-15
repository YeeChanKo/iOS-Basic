//
//  CardView.h
//  week5
//
//  Created by viz on 2017. 4. 12..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CARD_WIDTH 130
#define CARD_HEIGHT 150
#define PADDING_LEFT 26
#define PADDING_TOP_STACK 100
#define PADDING_TOP_BOTTOM 500
#define CARD_SPACING_WIDTH_STACK 10
#define CARD_SPACING_WIDTH_BOTTOM 24
#define CARD_SPACING_HEIGHT_STACK 40

@interface CardView : UIView

@property(readonly)NSMutableDictionary *cardImages;

-(void)initializeCardDeckReference:(NSMutableArray*)cardDeck;

@end
