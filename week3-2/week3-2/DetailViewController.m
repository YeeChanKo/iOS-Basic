//
//  DetailViewController.m
//  week3-2
//
//  Created by viz on 2017. 3. 29..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "DetailViewController.h"
#import "SecondViewController.h"
#import "MyModel.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SecondViewController* svc = (SecondViewController*) [self backViewController];
    NSLog(@"%d",svc.myModel.randomNumber);
    MyModel* model = svc.myModel;
    NSDictionary* dic = [model itemAtIndex:model.randomNumber];
    NSString* title = [dic valueForKey:@"title"];
    NSString* image = [dic valueForKey:@"image"];
    
    _titleLabel.text = title;
    [_imageView setImage:[UIImage imageNamed:image]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)backViewController
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
}

@end
