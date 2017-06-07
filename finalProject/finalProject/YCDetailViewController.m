//
//  SecondViewController.m
//  finalProject
//
//  Created by viz on 2017. 6. 7..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "YCDetailViewController.h"

@interface YCDetailViewController ()

@end

@implementation YCDetailViewController {
    YCMemo *memoToEdit;
    BOOL editFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set textview border
    [[self.textview layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.textview layer] setBorderWidth:1];
    [[self.textview layer] setCornerRadius:10];
    
    editFlag = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonClicked:(id)sender {
    YCMemo *memo = [[YCMemo alloc] init];
    memo.content = self.textview.text;
    memo.date = [NSDate date];
    memo.author = @"viz";
    
    if(!editFlag){
        memo.uuid = [[NSUUID UUID] UUIDString];
    }else{
        memo.uuid = memoToEdit.uuid;
    }
    
    [memo save];
    editFlag = NO;
    self.textview.text = @""; // clear
    [self.tabBarController setSelectedIndex:0];
}

- (void)setupForEdit:(YCMemo*)memo{
    memoToEdit = memo;
    self.textview.text = memoToEdit.content;
    editFlag = YES;
}

@end
