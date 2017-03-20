//
//  NXPenHolder.m
//  week1
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "NXPenHolder.h"

@implementation NXPenHolder

-(id)initWithCapacity:(int)capacity;
{
    self = [super init];
    if(!self) return nil;
    
    _capacity = capacity;
    _pens = [[NSMutableArray alloc] initWithCapacity:capacity];
    
    return self;
}

-(void)add:(NXPen *)pen;
{
    [_pens addObject:pen];
    NSLog(@"* 알림: 펜 하나 추가됨");
}

-(void)remove:(int)penIndex;
{
    if(penIndex < [_pens count])
    {
        [_pens removeObjectAtIndex:penIndex];
        // NSMutableArray removeObjectAtIndex 안에서 알아서 release 해준다
        NSLog(@"* 알림: 펜 하나 삭제됨");
    }
    else
        NSLog(@"* 삭제오류: 그런 펜 없어요");
}

-(int)usage;
{
    double count = (double)[_pens count];
    _usage = (int)(count/_capacity*100);
    return _usage;
}

-(void)printDescription;
{
    int count = (int)[_pens count];
    NSLog(@"---펜홀더 총 %d 중 %d 사용, %d%% 사용율---",
          _capacity, count, [self usage]);
    for(int i = 0; i < count; i++)
    {
        [[_pens objectAtIndex:i] printDescription];
    }
    NSLog(@"----------펜홀더-내용-끝----------");
}

@end
