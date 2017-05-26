//
//  ConcurrentOperation.h
//  week10_1
//
//  Created by viz on 2017. 5. 17..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConcurrentOperationQueue : NSObject

- (instancetype)initWithMaxConcurrentOperationCount:(int)count;
-(void)startConcurrentOperationQueueAndWait;
-(void)addConcurruentOperation:(void (^)())block;

@end
