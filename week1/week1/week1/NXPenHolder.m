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
    _capacity = capacity;
    _pens = [[NSMutableArray alloc] initWithCapacity:capacity];
    return self;
}

-(void)add:(NXPen *)pen;
{
    [_pens addObject:pen];
}

-(void)remove:(int)penIndex;
{
    [_pens removeObjectAtIndex:penIndex];
}

-(int)usage;
{
    return [_pens count];
}

-(void)printDescription;
{
    NSLog(@"pens=%@",_pens);
}

@end
