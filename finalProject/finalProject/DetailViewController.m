//
//  SecondViewController.m
//  finalProject
//
//  Created by viz on 2017. 6. 7..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "DetailViewController.h"
#import "YCMemo.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set textview border
    [[self.textview layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.textview layer] setBorderWidth:1];
    [[self.textview layer] setCornerRadius:10];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonClicked:(id)sender {
//    [YCMemo objectsWhere:@"index == %lu", ];
    
    YCMemo *memo = [[YCMemo alloc] init];
    memo.id = [[[NSUUID UUID] UUIDString] integerValue];
    memo.content = self.textview.text;
    memo.author = @"viz";
    memo.date = [NSDate date];
    
    [memo save];
    self.textview.text = @""; // clear
    [self.tabBarController setSelectedIndex:0];
}

@end
