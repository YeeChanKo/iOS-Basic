//
//  NXPen.m
//  week1
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "NXPen.h"

@implementation NXPen

-(id)initWithBrand:(NSString*)brand;
{
    if(self = [super init]){
        _brand = brand;
        return self;
    }
    else
        return nil;
}

-(NSString*)brand;
{
    return _brand;
}

-(NSString*)color;
{
    return _color;
}

-(int)usage;
{
    return _usage;
}

-(void)setBrand:(NSString*)brand;
{
    _brand = brand;
}

-(void)setColor:(NSString*)color;
{
    _color = color;
    
}

-(void)setUsage:(int)usage;
{
    _usage = usage;
}

-(void)printDescription;
{
    NSLog(@"브랜드가 %@이고 %d%% 사용가능한 %@ 색상의 펜", _brand, _usage, _color);
}

@end
