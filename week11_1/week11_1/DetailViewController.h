//
//  DetailViewController.h
//  week11_1
//
//  Created by viz on 2017. 5. 22..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "week11_1+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

