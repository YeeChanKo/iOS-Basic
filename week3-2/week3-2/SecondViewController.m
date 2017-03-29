//
//  SecondViewController.m
//  week3-2
//
//  Created by viz on 2017. 3. 29..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailViewController.h"
#import "MyModel.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myModel = [[MyModel alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchedRandomButton:(id)sender {
    int randomNumber = arc4random_uniform([_myModel getIndexCountOfArray]);
    _myModel.randomNumber = randomNumber;
    
    DetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
