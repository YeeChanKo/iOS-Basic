//
//  MyModel.m
//  week3-2
//
//  Created by viz on 2017. 3. 29..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel

- (instancetype)init;
{
    self = [super init];
    if (!self) return nil;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"txt"];
    NSString* jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    _nsArrayFromJson = [NSJSONSerialization JSONObjectWithData:jsonData
                                                       options:0 error:nil];
    
    return self;
}

- (NSDictionary*)itemAtIndex:(int)index;
{
    return _nsArrayFromJson[index];
}

- (int)getIndexCountOfArray;
{
    return (int)[_nsArrayFromJson count];
}


@end
