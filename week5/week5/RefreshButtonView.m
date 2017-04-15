//
//  RefreshButtonView.m
//  week5
//
//  Created by viz on 2017. 4. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "RefreshButtonView.h"

#import "StaticUtils.h"

@implementation RefreshButtonView

-(instancetype)initWithReference:(ViewController*)viewController
{
    // save reference
    _viewController = viewController;
    
    // initialize with frame, add image
    self = [super initWithFrame:CGRectMake(viewController.deviceMaxX-REFRESH_ICON_PADDING, viewController.deviceMaxY-REFRESH_ICON_PADDING, REFRESH_ICON_WIDTH, REFRESH_ICON_WIDTH)];
    self.image = [StaticUtils changeDimensions:[UIImage imageNamed:@"refresh.png"] :REFRESH_ICON_WIDTH :REFRESH_ICON_WIDTH];
    
    // add tap gesture - animate when touched
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animate)];
    singleTap.numberOfTapsRequired = 1;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
    
    return self;
}

-(void)animate
{
    [_viewController refreshButtonTouched];
    
    CABasicAnimation *rotate;
    rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"]; // autorelease
    rotate.fromValue = [NSNumber numberWithFloat:0]; // autorelease
    rotate.toValue = [NSNumber numberWithFloat:[StaticUtils deg2rad:360]]; // autorelease
    rotate.duration = 0.25;
    rotate.repeatCount = 1;
    rotate.removedOnCompletion = NO;
    
    // animation is done by its layer
    [self.layer addAnimation:rotate forKey:@"refresh.rotate"];
}

@end
