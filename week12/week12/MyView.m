//
//  MyView.m
//  week12
//
//  Created by viz on 2017. 5. 29..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "MyView.h"
#include "math.h"

@implementation MyView{
    CGPoint initialPoint;
    CGPoint currentPoint;
    UIColor *initialColor;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    initialColor = [UIColor colorWithRed:0.5 green:1 blue:1 alpha:1];
    self.backgroundColor = initialColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    initialPoint = [touch locationInView:self];
    
    if(touch.tapCount == 2){
        initialColor = [UIColor whiteColor];
    } else if (touch.tapCount == 3){
        initialColor = [UIColor blackColor];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    currentPoint = [touch locationInView:self];
    
    float distance = [self getDistanceFromPoint:initialPoint andPoint:currentPoint];
    
    self.backgroundColor = [initialColor colorWithAlphaComponent:1-distance/1000];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = initialColor;
    
    if([touches count] == 2){
        initialColor = [self createRandomColor];
    }
}

-(UIColor*)createRandomColor
{
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    CGFloat alpha = arc4random_uniform(255) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

-(float)getDistanceFromPoint:(CGPoint)point1 andPoint:(CGPoint)point2{
    float xDouble = pow(point1.x - point2.x, 2);
    float yDouble = pow(point1.y - point2.y, 2);
    float combinedRoot = sqrtf(xDouble+yDouble);
    
//    NSLog(@"%f, %f, %f", xDouble, yDouble, combinedRoot);
    
    return combinedRoot;
}

@end
