//
//  PhotoViewController.m
//  midTermProject
//
//  Created by viz on 2017. 5. 1..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController{
    NSString *name;
    NSString *date;
    NSString *imagePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameLabel.text = name;
    _dateLabel.text = date;
    _imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareData:(NSDictionary*)data{
    name = [data objectForKey:@"title"];
    date = [data objectForKey:@"date"];
    imagePath = [data objectForKey:@"image"];
}

@end
