//
//  RefreshButtonView.h
//  week5
//
//  Created by viz on 2017. 4. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#define REFRESH_ICON_WIDTH 80
#define REFRESH_ICON_PADDING 100

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface RefreshButtonView : UIImageView

@property(weak) ViewController *viewController;

-(instancetype)initWithReference:(ViewController*)viewController;

@end
