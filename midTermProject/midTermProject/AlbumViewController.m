//
//  ViewController.m
//  midTermProject
//
//  Created by viz on 2017. 5. 1..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "AlbumViewController.h"
#import "DataModel.h"
#import "CustomTableViewCell.h"
#import "PhotoViewController.h"
#import "SectionRowInfo.h"

@interface AlbumViewController ()
@end

@implementation AlbumViewController{
    DataModel *dataModel;
    SectionRowInfo *sectionRowInfo;
    STATUS lastStatus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(dataModelDidChange) name:@"DATA_MODEL_CHANGED" object:nil];
    
    dataModel = [[DataModel alloc] init];
//    [dataModel sortByTitle];
    
    // setting default sectionRowInfo
    sectionRowInfo = [[SectionRowInfo alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataModelDidChange{
    NSLog(@"called");
    if(dataModel.status == lastStatus){
        [self.tableView reloadData];
        return;
    }
    NSLog(@"called2");
    
    switch (dataModel.status) {
        case UNSORTED:
        case SORT_BY_TITLE:
            [self initSectionRowInfoForDefault];
            break;
        case SORT_BY_DATE:
            [self initSectionRowInfoForSortByDate];
            break;
    }
    
    [self.tableView reloadData];
    lastStatus = dataModel.status;
}

-(void)initSectionRowInfoForDefault{
    NSLog(@"%lu", [dataModel.imageInfo count]);
    [sectionRowInfo setDefaultRowPerSectionAndIndexMappingWithRowCount:[dataModel.imageInfo count]];
}

-(void)initSectionRowInfoForSortByDate{
    [sectionRowInfo resetSectionRowInfo];
    __block int section = -1; // to make initial value as 0
    __block int row;
    __block NSString *yearStr = @"";
    [dataModel.imageInfo enumerateObjectsUsingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
        NSString *date = [dic objectForKey:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *nsDate = [formatter dateFromString:date];
        NSInteger year = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:nsDate];
        
        if(![yearStr isEqualToString:@(year).stringValue]){
            yearStr = @(year).stringValue;
            section++;
            row = 0;
            [sectionRowInfo setText:yearStr OfSection:@(section).stringValue];
        }
        
        [sectionRowInfo mapIndex:idx toIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        [sectionRowInfo incrementRowInSection:@(section).stringValue];
        row++;
    }];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sectionRowInfo getCountOfSections];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [sectionRowInfo getCountOfRowsInSection:section];
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CUSTOM_CELL" forIndexPath:indexPath];
    NSUInteger index = [sectionRowInfo getIndexForIndexPath:indexPath];
    NSLog(@"%lu", index);
    NSDictionary *info = [dataModel.imageInfo objectAtIndex:index];
    NSLog(@"%@", info);
    
    [self setupCell:cell withInfo:info];
    
    return cell;
}

- (void)setupCell:(CustomTableViewCell*)cell withInfo:(NSDictionary*)info {
    cell.nameLabel.text = [info objectForKey:@"title"];
    cell.dateLabel.text = [info objectForKey:@"date"];
    cell.dateLabel.textColor = [UIColor greenColor];
    
    NSString *imgName = [info objectForKey:@"image"];
    UIImage *img = [dataModel createUIImageWithName:imgName];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.contentMode = UIViewContentModeCenter;
    cell.backgroundView = imgView;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqual: @"SHOW_PHOTO"]) {
        PhotoViewController *vc = [segue destinationViewController];
        NSUInteger index = [sectionRowInfo getIndexForIndexPath:[self.tableView indexPathForSelectedRow]];
        NSMutableDictionary *info = [[dataModel.imageInfo objectAtIndex:index] mutableCopy];
        NSString *imgName = [info objectForKey:@"image"];
//        [info setObject:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"images/%@",imgName] ofType:nil]
//                 forKey:@"image"];
        [info setObject:[NSString stringWithFormat:@"%@/%@",dataModel.cacheDir,imgName] forKey:@"image"];
        [vc prepareData:info];
    }
}

- (IBAction)rightBarButtonTouched:(id)sender {
    [dataModel sortByDate];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if ( event.subtype == UIEventSubtypeMotionShake ){
        [dataModel setInitialData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (dataModel.status) {
        case UNSORTED:
        case SORT_BY_TITLE:
            return nil;
        case SORT_BY_DATE:
            return [sectionRowInfo getTextOfsection:@(section).stringValue];
    }
}

@end
