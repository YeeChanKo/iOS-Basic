//
//  SectionRowInfo.m
//  midTermProject
//
//  Created by viz on 2017. 5. 9..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "SectionRowInfo.h"

@implementation SectionRowInfo

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _info = [[NSMutableDictionary alloc] init];
    _indexMapper = [[NSMutableDictionary alloc] init];
    _textOfSections = [[NSMutableDictionary alloc] init];
    
    return self;
}

-(void)setDefaultRowPerSectionAndIndexMappingWithRowCount:(NSUInteger)count{
    [self resetSectionRowInfo];
    [self setDefaultRowPerSectionWithRowCount:count];
    [self setDefaultIndexMappingWithRowCount:count];
}

-(void)setDefaultRowPerSectionWithRowCount:(NSUInteger)count{
    [_info addEntriesFromDictionary:@{@"0":@(count)}];
}

// section 0, index = row
-(void)setDefaultIndexMappingWithRowCount:(NSUInteger)arrayCount{
    for(NSUInteger i = 0; i < arrayCount; i++){
        [self mapIndex:i toIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
}

-(NSInteger)getCountOfSections{
    return [[_info allKeys] count];
}

-(NSInteger)getCountOfRowsInSection:(NSInteger)section{
    NSNumber *number = [_info objectForKey:[@(section) stringValue]];
    return [number integerValue];
}

-(void)addRowPerSection:(NSDictionary*)rowPerSection{
    [_info addEntriesFromDictionary:rowPerSection];
}

-(void)modifyRowInSection:(NSString*)section toRow:(NSNumber*)row{
    [_info setObject:row forKey:section];
}

-(void)mapIndex:(NSUInteger)index toIndexPath:(NSIndexPath*)indexPath{
    [_indexMapper setObject:@(index) forKey:indexPath];
}

-(NSUInteger)getIndexForIndexPath:(NSIndexPath*)indexPath{
    return [[_indexMapper objectForKey:indexPath] unsignedIntegerValue];
}

-(void)resetSectionRowInfo{
    [_info removeAllObjects];
    [_indexMapper removeAllObjects];
    [_textOfSections removeAllObjects];
}

-(void)incrementRowInSection:(NSString*)section{
    NSNumber *before = [_info objectForKey:section];
    NSNumber *after;
    if(before == nil){
        after = @1;
    }else{
        after = @([before intValue] + 1);
    }
    
    [_info setObject:after forKey:section];
}

-(void)setText:(NSString*)text OfSection:(NSString*)section{
    [_textOfSections setObject:text forKey:section];
}

-(NSString*)getTextOfsection:(NSString*)section{
    return [_textOfSections objectForKey:section];
}

@end
