//
//  SectionRowInfo.h
//  midTermProject
//
//  Created by viz on 2017. 5. 9..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SectionRowInfo : NSObject

@property NSMutableDictionary *info; // key:sectionNumber(NSString), value:countOfRow(NSNumber)
@property NSMutableDictionary *indexMapper; // key:indexPath(NSIndexPath), value:index(NSNumber)
@property NSMutableDictionary *textOfSections; // key:sectionNumber(NSString), value:textOfSection(NSString)

- (instancetype)init;
-(void)setDefaultRowPerSectionAndIndexMappingWithRowCount:(NSUInteger)count;
-(NSInteger)getCountOfSections;
-(NSInteger)getCountOfRowsInSection:(NSInteger)section;
-(void)addRowPerSection:(NSDictionary*)rowPerSection;
-(void)modifyRowInSection:(NSString*)section toRow:(NSNumber*)row;
-(void)mapIndex:(NSUInteger)index toIndexPath:(NSIndexPath*)indexPath;
-(NSUInteger)getIndexForIndexPath:(NSIndexPath*)indexPath;
-(void)resetSectionRowInfo;
-(void)incrementRowInSection:(NSString*)section;
-(void)setText:(NSString*)text OfSection:(NSString*)section;
-(NSString*)getTextOfsection:(NSString*)section;

@end
