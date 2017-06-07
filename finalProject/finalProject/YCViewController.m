//
//  CollectionViewController.m
//  finalProject
//
//  Created by viz on 2017. 6. 7..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "YCViewController.h"
#import <Realm/Realm.h>
#import "YCMemo.h"
#import "YCCollectionViewCell.h"
#import "YCDetailViewController.h"

@interface YCViewController ()

@end

@implementation YCViewController {
    RLMResults<YCMemo*> *memos;
    YCDetailViewController *detailViewController;
}

static NSString * const reuseIdentifier = @"default";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // inset status bar and tab bar
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 50, 0);
    
    memos = [YCMemo allObjects];
    
    // instantiate detailviewcontroller for edit
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"detail"];
    detailViewController.editFlag = YES;
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(dataModelChanged) name:@"DATA_MODEL_CHANGED" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataModelChanged {
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [memos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    YCMemo *memo = [memos objectAtIndex:[indexPath row]];
    cell.content.text = memo.content;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    cell.date.text = [formatter stringFromDate: memo.date];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YCMemo *memo = [memos objectAtIndex:[indexPath row]];
    detailViewController.memoToEdit = memo;
    [self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark collection view layout settings
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int itemPerRow = 3;
    CGFloat deviceMaxWidth = CGRectGetMaxX(self.view.bounds);
    CGFloat itemWidth = (deviceMaxWidth - 10 * (itemPerRow + 1)) / itemPerRow;
    CGSize cellSize = CGSizeMake(itemWidth, itemWidth);
    return cellSize;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,10,10,10);  // top, left, bottom, right
}

@end
