//
//  ScrollView.h
//  week7
//
//  Created by viz on 2017. 4. 26..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface ScrollView : UIScrollView

@property NSMutableArray *imageArr;

- (instancetype)initWithViewController:(ViewController*)viewController;
-(void)addImageViewAtIndex:(int)x;

@end
