//
//  DataModel.m
//  midTermProject
//
//  Created by viz on 2017. 5. 1..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "DataModel.h"
#import "Reachability.h"

@implementation DataModel{
    NSURLSession *session;
    NSFileManager *fileManager;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    _cacheDir = [paths objectAtIndex:0]; // 마지막에 / 없음
    
//    if([self testReachability]){
        [self setInitialDataWithNetwork];
//    }
//    else{
//        [self setInitialData];
//    }
    
    return self; // 이것보다 post noti 가 먼저 일어나면 안됨
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
    
    self.status = UNSORTED;
    [self postNotificationWithName:@"DATA_MODEL_CHANGED"];
}

-(void)setInitialDataWithNetwork{
    NSURL *url = [NSURL URLWithString:@"http://125.209.194.123/json.php"];
    [[session dataTaskWithURL:url completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error) {
          _imageInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
          NSLog(@"%@", _imageInfo);
          [self downloadImageData];
      }] resume];
    
    self.status = UNSORTED;
    [self postNotificationWithName:@"DATA_MODEL_CHANGED"];
}

-(void)downloadImageData{
    NSLog(@"%@", _cacheDir);
    
    [_imageInfo enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = [obj objectForKey:@"image"];
        NSString *urlPath = [NSString stringWithFormat:@"http://125.209.194.123/demo/%@", filename];
        [[session downloadTaskWithURL:[NSURL URLWithString:urlPath] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            [fileManager moveItemAtPath:[location path] toPath:[NSString stringWithFormat:@"%@/%@", _cacheDir, filename] error:nil];
        }] resume];
    }];
    [self postNotificationWithName:@"DATA_MODEL_CHANGED"];
}

-(UIImage*)createUIImageWithName:(NSString*)imageName{
//    if([self testReachability]){
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", _cacheDir, imageName];
        return [UIImage imageWithContentsOfFile:filePath];
//    }else{
//        // 기존 번들에서 가져오기
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"images/%@", imageName] ofType:nil];
//        return [UIImage imageWithContentsOfFile:filePath];
//    }
}

-(void)sort:(NSArray*)arr ByItem:(NSString*)item{
    _imageInfo = [arr sortedArrayUsingComparator:^(NSDictionary *obj1, NSDictionary *obj2) {
        NSString* s1 = [obj1 objectForKey:item];
        NSString* s2 = [obj2 objectForKey:item];
        return [s1 compare:s2];
    }];
}

-(void)postNotificationWithName:(NSString*)name{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}

-(void)sortByTitle{
    [self sort:_imageInfo ByItem:@"title"];
    self.status = SORT_BY_TITLE;
    [self postNotificationWithName:@"DATA_MODEL_CHANGED"];
}

-(void)sortByDate{
    [self sort:_imageInfo ByItem:@"date"];
    self.status = SORT_BY_DATE;
    [self postNotificationWithName:@"DATA_MODEL_CHANGED"];
}

-(BOOL)testReachability{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if ([reach currentReachabilityStatus] == NotReachable) {
        NSLog(@"Device is not connected to the internet");
        return NO;
    }
    else {
        NSLog(@"Device is connected to the internet");
        return YES;
    }
}

@end
