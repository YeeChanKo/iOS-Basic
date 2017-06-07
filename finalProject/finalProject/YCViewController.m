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

@end
