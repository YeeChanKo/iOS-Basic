//
//  ViewController.m
//  week5
//
//  Created by viz on 2017. 4. 12..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "ViewController.h"

#import "CardView.h"
#import "CardModel.h"
#import "RefreshButtonView.h"

@implementation ViewController
{
    CardView* cardView;
    CardModel* cardModel;
    RefreshButtonView* refreshButton;
    CALayer* refreshButtonLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDeviceInfo];
    
    cardView = (CardView*)self.view; // reference
    cardModel = [[CardModel alloc] init]; // permanent
    cardModel.cardDeck = [[NSMutableArray alloc] initWithArray:[cardView.cardImages allKeys]]; // permanent
    [cardView initializeCardDeckReference:cardModel.cardDeck];
    
    [self setUpRefreshButton];
}

-(void)setUpRefreshButton
{
    // set up refresh button - display, animate
    refreshButton = [[RefreshButtonView alloc] initWithReference:self]; // permanent
    // add refreshbutton's layer as sublayer for animation
    [[self.view layer] addSublayer:[refreshButton layer]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDeviceInfo
{
    _deviceMaxX = CGRectGetMaxX(self.view.bounds);
    _deviceMaxY = CGRectGetMaxY(self.view.bounds);
}

-(void)refreshButtonTouched
{
    [cardModel shuffleCards];
    [cardView setNeedsDisplay];
}

@end
