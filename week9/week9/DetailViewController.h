//
//  DetailViewController.h
//  week9
//
//  Created by viz on 2017. 5. 10..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <NSURLSessionStreamDelegate, NSStreamDelegate>

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *screenImage;

@end

