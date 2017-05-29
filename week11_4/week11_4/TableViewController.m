//
//  TableViewController.m
//  week11_4
//
//  Created by viz on 2017. 5. 25..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "TableViewController.h"
#import "StudentDataManager.h"

@interface TableViewController ()

@end

@implementation TableViewController{
    StudentDataManager *studentDataManager;
    NSFetchedResultsController *fetchedResultsController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // prevents status bar overlapping
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    // add notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView:) name:StudentDataManager.STUDENT_DATA_CHANGED object:nil];
    NSLog(@"notification added");
    
    // member variables initialzation
    studentDataManager = [StudentDataManager getInstance];
    fetchedResultsController = [studentDataManager fetchedResultsController];
    
    // test
    [studentDataManager deleteStudentWithStudentId:@"140000"];
}

-(void)updateTableView:(NSNotification*)noti{
    NSLog(@"update table view called");
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default" forIndexPath:indexPath];
    Student *student = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = student.name;
    cell.detailTextLabel.text = student.student_id;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
