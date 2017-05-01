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
    NSMutableArray *jsonArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    _imageInfo = [[NSMutableArray alloc] initWithArray:
    [jsonArr sortedArrayUsingComparator:^(NSDictionary *obj1, NSDictionary *obj2) {
        NSString* title1 = [obj1 objectForKey:@"title"];
        NSString* title2 = [obj2 objectForKey:@"title"];
        return [title1 compare:title2];
    }]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DATA_MODEL" object:nil];
    
    return self;
}

-(NSString*)getTitleFromIndex:(NSInteger)index{
    
    NSString *title =[[_imageInfo objectAtIndex:index] objectForKey:@"title"];
    return title;
}



@end
