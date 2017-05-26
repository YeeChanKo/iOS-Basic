//
//  TableViewController.m
//  week11
//
//  Created by viz on 2017. 5. 22..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "TableViewController.h"
#import "FMDB.h"

@interface TableViewController ()

@end

@implementation TableViewController{
    NSInteger numberOfRow;
    NSMutableArray *songs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(30, 0, 0, 0)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"top25" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        db = nil;
        
        return;
    }
    
    songs = [[NSMutableArray alloc] init];
    FMResultSet *s = [db executeQuery:@"SELECT * FROM tbl_songs"];
    while ([s next]) {
        NSDictionary *dic = @{
                              @"title": [s stringForColumn:@"title"],
                              @"category": [s stringForColumn:@"category"]
                              };
        [songs addObject:dic];
    }
    
    numberOfRow = [songs count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default" forIndexPath:indexPath];
    
    NSDictionary *dic = [songs objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"category"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
