//
//  YCMemo.m
//  finalProject
//
//  Created by viz on 2017. 6. 7..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "YCMemo.h"

@implementation YCMemo {
    RLMRealm *realm;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    realm = [RLMRealm defaultRealm];
    
    return self;
}

+(NSString *)primaryKey {
    return @"id";
}

-(void)save {
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:self];
        NSLog(@"%@ saved", self);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DATA_MODEL_CHANGED" object:nil];
}

@end
