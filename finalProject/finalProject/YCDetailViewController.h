//
//  SecondViewController.h
//  finalProject
//
//  Created by viz on 2017. 6. 7..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCMemo.h"

@interface YCDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textview;
- (void)setupForEdit:(YCMemo*)memo;
@end

