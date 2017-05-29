//
//  ViewController.m
//  week11_4
//
//  Created by viz on 2017. 5. 25..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "ViewController.h"
#import "StudentDataManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *student_id;
@property (weak, nonatomic) IBOutlet UISwitch *gender;
@property (weak, nonatomic) IBOutlet UITextField *grade;

@end

@implementation ViewController{
    StudentDataManager *studentDataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    studentDataManager = [StudentDataManager getInstance];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonClicked:(id)sender {
    
    // get inputs
    NSString *name = _name.text;
    NSString *student_id = _student_id.text;
    BOOL gender = _gender.isOn;
    int grade = [_grade.text intValue];
    
    // create student
    [studentDataManager createStudentWithName:name student_id:student_id gender:gender grade:grade];
    
    // empty inputs
    _name.text = @"";
    _student_id.text = @"";
    [_gender setOn:YES];
    _grade.text = @"";
    
    // move to the list
    [self.tabBarController setSelectedIndex: 0];
}

-(void)presentAlertWithTitle:(NSString*)title message:(NSString*)message{
    UIAlertController* alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
