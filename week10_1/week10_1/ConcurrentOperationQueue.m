//
//  ConcurrentOperation.m
//  week10_1
//
//  Created by viz on 2017. 5. 17..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "ConcurrentOperationQueue.h"

@implementation ConcurrentOperationQueue{
    NSOperationQueue *queue;
}

- (instancetype)initWithMaxConcurrentOperationCount:(int)count {
    self = [super init];
    if (!self) return nil;
    queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:count];
    [queue setSuspended:YES];
    return self;
}

-(void)startConcurrentOperationQueueAndWait {
    [queue setSuspended:NO];
    [queue waitUntilAllOperationsAreFinished];
}

-(void)addConcurruentOperation:(void (^)())block{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:block];
    [queue addOperation:op];
}

@end
