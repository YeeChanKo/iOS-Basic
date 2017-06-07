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

@implementation YCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // set textview border
    [[self.textview layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.textview layer] setBorderWidth:1];
    [[self.textview layer] setCornerRadius:10];
}

- (void)viewWillAppear:(BOOL)animated {
    if(_editFlag){
        self.textview.text = _memoToEdit.content;
    }
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
    
    if(!_editFlag){
        memo.uuid = [[NSUUID UUID] UUIDString];
    }else{
        memo.uuid = _memoToEdit.uuid;
    }
    
    [memo save];
    self.textview.text = @""; // clear
    
    if(!_editFlag){
        [self.tabBarController setSelectedIndex:0];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

@end
