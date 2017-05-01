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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(dataModelDidChange) name:@"DATA_MODEL_CHANGED" object:nil];
    
    dataModel = [[DataModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataModelDidChange{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataModel.imageInfo count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CUSTOM_CELL" forIndexPath:indexPath];
    
    NSDictionary *info = [dataModel.imageInfo objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [info objectForKey:@"title"];
    cell.dateLabel.text = [info objectForKey:@"date"];
    cell.dateLabel.textColor = [UIColor greenColor];
    
    NSString* imgPath = [NSString stringWithFormat:@"images/%@", [info objectForKey:@"image"]];
    UIImage *image = [UIImage imageNamed: imgPath];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:image];
    imgView.contentMode = UIViewContentModeCenter;
    cell.backgroundView = imgView;
                            
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"SHOW_PHOTO"]) {
        
        PhotoViewController *vc = [segue destinationViewController];
        NSDictionary *info = [dataModel.imageInfo objectAtIndex:[self.tableView indexPathForSelectedRow].row];
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
