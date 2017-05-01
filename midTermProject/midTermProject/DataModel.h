//
//  DataModel.h
//  midTermProject
//
//  Created by viz on 2017. 5. 1..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property NSArray *imageInfo;

- (instancetype)init;
-(void)setInitialData;
-(void)sortByTitle;
-(void)sortByDate;

@end