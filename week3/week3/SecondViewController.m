//
//  SecondViewController.m
//  week3
//
//  Created by viz on 2017. 3. 27..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "SecondViewController.h"
#import "NXPersonModel.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *studentNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAllStudent:(id)sender {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"persons" ofType:@"txt"];
    NSLog(@"%@",filePath);
    
    NXPersonModel* test = [[NXPersonModel alloc] init];
    
    [test readPersonsFromFile:filePath];
    
    NSString* msg = @"";
    
    NSArray* array =[test sortedByName];
    for(NSDictionary* dic in array){
        NSString* person;
        NSString* name = [dic valueForKey:@"name"];
        NSNumber* number = [dic valueForKey:@"number"];
        NSString* sex = [dic valueForKey:@"sex"];
        NSNumber* team = [dic valueForKey:@"team"];
        person = [NSString stringWithFormat:@"%@ %@ %@ %@\n",name, [number stringValue], sex, [team stringValue]];
        msg = [msg stringByAppendingString:person];
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"학생정보" message:msg
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)findByStudentNumberButtonTouched:(id)sender {
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"persons" ofType:@"txt"];
    NSLog(@"%@",filePath);
    
    NXPersonModel* test = [[NXPersonModel alloc] init];
    NSString* input = _studentNumberTextField.text;
    NSLog(@"%@", input);
    
    [test readPersonsFromFile:filePath];
    NSString* personName = [test findPersonNameByNumber:[NXPersonModel convertNSStringToNSNumber:input]];
    
    _resultLabel.text=personName;
    
    [_studentNumberTextField resignFirstResponder];
    
    _studentNumberTextField.text = @"";
    
    
}

@end
