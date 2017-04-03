//
//  MyView.m
//  week4
//
//  Created by viz on 2017. 4. 3..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "MyView.h"

@implementation MyView
{
    float deviceMaxX;
    float deviceMaxY;
    float deviceMidX;
}

// initwithcoder
// awakerfromlib
// initwithframe
// 초기화
- (void)awakeFromNib
{
    [super awakeFromNib];
    deviceMaxX = CGRectGetMaxX(self.bounds);
    deviceMaxY = CGRectGetMaxY(self.bounds);
    deviceMidX = CGRectGetMidX(self.bounds);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawRandomGradientWithContext:context];
    
    for(int i = 0; i < 10;i++)
    {
        [self drawRandomArc];
        [self drawRandomLine];
    }
}

-(void)drawRandomGradientWithContext:(CGContextRef)context
{
    CGGradientRef gradient = [self newGradient];
    // startpoint부터 endpoint까지 주어진 방향으로 무한히 긴 직선을 그려나가는 방식
    CGPoint startPoint = CGPointMake(deviceMidX, 0);
    CGPoint endPoint = CGPointMake(deviceMidX, deviceMaxY);
    
    // 마지막 파라미터는 options
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
}

- (CGGradientRef)newGradient{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CFArrayRef colors = (__bridge CFArrayRef)[NSArray arrayWithObjects:(id)[self makeRandomColor].CGColor, (id)[self makeRandomColor].CGColor, nil];
    CGFloat locations[2] = {0.0, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
    CGColorSpaceRelease(colorSpace);
    
    return gradient;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}

-(UIColor*)makeRandomColor
{
    return [UIColor colorWithRed:[self randomNum:1] green:[self randomNum:1] blue:[self randomNum:1] alpha:[self randomNum:1]];
}

-(void)drawRandomLine
{
    CGPoint startPoint = [self makeRandomPoint];
    CGPoint endPoint = [self makeRandomPoint];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    [path setLineWidth:[self randomNum:20]];
    [[self makeRandomColor] setStroke];
    [path stroke];
}

-(float)randomNum:(float)maxNum
{
    return ((float)rand() / RAND_MAX) * maxNum;
}

-(CGPoint)makeRandomPoint
{
    return CGPointMake([self randomNum:deviceMaxX],[self randomNum:deviceMaxY]);
}

-(void)drawRandomArc
{
    CGPoint center = [self makeRandomPoint];
    float radius = [self randomNum:(deviceMaxY/4)];
    float startAngle = [self randomNum:8] * M_PI / 4;
    float endAngle = [self randomNum:8] * M_PI / 4;
    float arcWidth = [self randomNum:radius];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius
                                                    startAngle:startAngle endAngle:endAngle clockwise:true];
    
    [path setLineWidth:arcWidth];
    [[self makeRandomColor] setStroke];
    [path stroke];
}

@end
