//
//  DataModel.m
//  midTermProject
//
//  Created by viz on 2017. 5. 1..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    [self setInitialData];
    [self sortByTitle];
    
    return self;
}

-(void)setInitialData{
    char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20150116\"},\
    {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20160505\"},\
    {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20141212\"},\
    {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20140301\"},\
    {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20150101\"},\
    {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20150707\"},\
    {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20140815\"},\
    {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20161231\"},\
    {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20150102\"},\
    {\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20141225\"}]";
    
    NSData* jsonData = [NSData dataWithBytes:data length:strlen(data)];
    _imageInfo = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    [self postNotification];
}

-(NSArray*)sort:(NSArray*)arr ByItem:(NSString*)item{
    NSArray* result = [arr sortedArrayUsingComparator:^(NSDictionary *obj1, NSDictionary *obj2) {
        NSString* s1 = [obj1 objectForKey:item];
        NSString* s2 = [obj2 objectForKey:item];
        return [s1 compare:s2];
    }];
    
    [self postNotification];
    return result;
}

-(void)postNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DATA_MODEL_CHANGED" object:nil];
}

-(void)sortByTitle{
    _imageInfo = [self sort:_imageInfo ByItem:@"title"];
}

-(void)sortByDate{
    _imageInfo = [self sort:_imageInfo ByItem:@"date"];
}


@end
