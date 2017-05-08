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

@interface AlbumViewController ()
@end

@implementation AlbumViewController{
    DataModel *dataModel;
    NSMutableDictionary *sectionRowInfo;
    NSMutableDictionary *indexMapper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(dataModelDidChange) name:@"DATA_MODEL_CHANGED" object:nil];
    
    dataModel = [[DataModel alloc] init];
    sectionRowInfo = [[NSMutableDictionary alloc] init];
    [sectionRowInfo setObject:@1 forKey:@"sectionCount"];
    //([dataModel.imageInfo count])
    [sectionRowInfo setObject:@50 forKey:@"0"];
    indexMapper = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataModelDidChange{
    [self.tableView reloadData];
    
    // TODO: section 정보 sectionrowinfo 에 넣어주기
//    [dataModel.imageInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSDictionary *dic = obj;
//        
//        NSString *date = [dic objectForKey:@"date"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyyMMdd"];
//        NSDate *nsDate = [formatter dateFromString:date];
//        NSInteger year = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:nsDate];
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	   return [[sectionRowInfo objectForKey:@"sectionCount"] integerValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[sectionRowInfo objectForKey:@(section).stringValue] integerValue];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CUSTOM_CELL" forIndexPath:indexPath];
    
    NSDictionary *info = [dataModel.imageInfo objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [info objectForKey:@"title"];
    cell.dateLabel.text = [info objectForKey:@"date"];
    cell.dateLabel.textColor = [UIColor greenColor];
    
    NSString *imgName = [info objectForKey:@"image"];
    UIImage *img = [dataModel createUIImageWithName:imgName];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.contentMode = UIViewContentModeCenter;
    cell.backgroundView = imgView;
                            
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"SHOW_PHOTO"]) {
        
        PhotoViewController *vc = [segue destinationViewController];
        NSMutableDictionary *info = [[dataModel.imageInfo objectAtIndex:[self.tableView indexPathForSelectedRow].row] mutableCopy];
        NSString *imgName = [info objectForKey:@"image"];
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
    
    
    return @"test yo";
}

@end
