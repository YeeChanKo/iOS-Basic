//
//  PhotoViewController.h
//  midTermProject
//
//  Created by viz on 2017. 5. 1..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)prepareData:(NSDictionary*)data;

@end
