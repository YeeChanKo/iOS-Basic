//
//  NXPen.h
//  week1
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPen:NSObject
{
    NSString* _brand;
    NSString* _color;
    int _usage;
}

-(id)initWithBrand:(NSString*)brand;

-(NSString*)brand;
-(NSString*)color;
-(int)usage;

-(void)setBrand:(NSString*)brand;
-(void)setColor:(NSString*)color;
-(void)setUsage:(int)usage;

-(void)printDescription;

@end
