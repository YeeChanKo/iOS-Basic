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
@property (weak, nonatomic) IBOutlet UILabel *warning;
@property (weak, nonatomic) IBOutlet UISwitch *gender;
@property (weak, nonatomic) IBOutlet UITextField *grade;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation ViewController{
    StudentDataManager *studentDataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    studentDataManager = [StudentDataManager getInstance];
    _addButton.enabled = NO;
    _warning.hidden = YES;
}

- (IBAction)editingChanged:(id)sender {
    // check if empty
    if([_name.text length] != 0 && [_student_id.text length] != 0 && [_grade.text length] != 0){
        // check if same id exists
        NSArray<Student*> *results = [studentDataManager retrieveStudentsWithStudentId:_student_id.text];
        if([results count] == 0){
            _warning.hidden = YES;
            _addButton.enabled = YES;
            return;
        }else{
            _warning.hidden = NO;
        }
    }
    _addButton.enabled = NO;
    return;
}

- (BOOL)isNumberOnString:(NSString*)input {
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return ([input rangeOfCharacterFromSet:notDigits].location == NSNotFound);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonClicked:(id)sender {
    
    // check if student id is a number
    if(![self isNumberOnString:_student_id.text]){
        [self presentAlertWithTitle:@"check your student id" message:@"student id need to be numeral characters"];
        return;
    }
    
    // check if grade is a number
    if(![self isNumberOnString:_grade.text]){
        [self presentAlertWithTitle:@"check your grade" message:@"grade need to be numeral characters"];
        return;
    }
    
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
    
    // init cursor focus to name field
    [_name becomeFirstResponder];
    
    // move to the list tab
    [self.tabBarController setSelectedIndex: 0];
}

-(void)presentAlertWithTitle:(NSString*)title message:(NSString*)message{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
