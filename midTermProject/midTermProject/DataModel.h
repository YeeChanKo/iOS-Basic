//
//  DataModel.h
//  midTermProject
//
//  Created by viz on 2017. 5. 1..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataModel : NSObject

@property NSArray *imageInfo;
@property NSString *cacheDir;

- (instancetype)init;
-(void)setInitialData;
-(void)sortByTitle;
-(void)sortByDate;
-(UIImage*)createUIImageWithName:(NSString*)imageName;

@end
