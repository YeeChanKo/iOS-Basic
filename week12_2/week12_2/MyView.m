//
//  MyView.m
//  week12_2
//
//  Created by viz on 2017. 5. 31..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "MyView.h"

@implementation MyView{
    NSMutableArray<NSValue *> *pathArray;
    CGFloat pathWidth;
    UIColor *pathColor;
    __weak IBOutlet UILabel *output;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    pathArray = [[NSMutableArray alloc] init];
    pathWidth = 5;
    pathColor = [UIColor blackColor];
}

- (void)drawRect:(CGRect)rect {
    if([pathArray count] == 0){
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startPoint, endPoint = pathArray[0].CGPointValue;
    
    for(int i = 1; i < [pathArray count]; i++)
    {
        startPoint = endPoint;
        endPoint = pathArray[i].CGPointValue;
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
    }
    
    [path setLineWidth:pathWidth];
    [pathColor setStroke];
    [path stroke];
    
    output.text = [self recognizeNumber];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    pathArray = [[NSMutableArray alloc] init];
    [pathArray addObject:[NSValue valueWithCGPoint:point]];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [pathArray addObject:[NSValue valueWithCGPoint:point]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [pathArray addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

-(NSString*)recognizeNumber{
    NSString *result = @"";
    
    if([self recognizeArabianZero]){
        result = @"0";
    }else if([self recognizeArabianOne]){
        result = @"1";
    }else if([self recognizeArabianTwo]){
        result = @"2";
    }
    
    return result;
}

-(BOOL)recognizeArabianZero{
    CGPoint current, next = pathArray[0].CGPointValue;
    int i = 1;
    
    // stage 1
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // x 작고 y 커야함
        if(next.x > current.x || next.y < current.y){
            break;
        }
    }
    
    // stage 2
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // x 크고 y 커야함
        if(next.x < current.x || next.y < current.y){
            break;
        }
    }
    
    // stage 3
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // x 크고 y 작야함
        if(next.x < current.x || next.y > current.y){
            break;
        }
    }
    
    // stage 4
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // x 작고 y 작야함
        if(next.x > current.x || next.y > current.y){
            break;
        }
    }
    
    if(i != [pathArray count]){
        return NO;
    }
    // 시작점과 끝점 거리가 30 이내여야 함
    if([self getDistanceBetweenPointOne:pathArray[0].CGPointValue andPointTwo:pathArray[i-1].CGPointValue] < 30){
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)recognizeArabianOne{
    float current, last = pathArray[0].CGPointValue.y;
    for(int i = 1; i < [pathArray count]; i++){
        current = pathArray[i].CGPointValue.y;
        if(last > current){
            return NO;
        }
        
        last = current;
    }
    
    // 역탄젠트 이용해 각도 검증 - 80도 이상일 때만 참
    CGPoint start = pathArray[0].CGPointValue;
    CGPoint end = pathArray[[pathArray count] - 1].CGPointValue;
    float xAbsDiff = fabs(start.x - end.x);
    float yAbsDiff = fabs(start.y - end.y);
    float degree = atanf(yAbsDiff/xAbsDiff) / M_PI * 180;
    
    if(degree < 80){
        return NO;
    }else{
        return YES;
    }
}

-(BOOL)recognizeArabianTwo{
    
    CGPoint current, next = pathArray[0].CGPointValue;
    int i = 1;
    
    // stage 1
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // x 크고 y 작야함
        if(next.x < current.x || next.y > current.y){
            break;
        }
    }
    
    // stage 2
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // x 크고 y 커야함
        if(next.x < current.x || next.y < current.y){
            break;
        }
    }
    
    // stage 3
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // x 작고 y 커야함
        if(next.x > current.x || next.y < current.y){
            break;
        }
    }
    
    // stage 4
    for(; i< [pathArray count]; i++){
        current = next;
        next = pathArray[i].CGPointValue;
        // y가 앞의 것과 비슷해야 함
        if(fabs(next.y - current.y) > 5){
            break;
        }
    }
    
    if(i != [pathArray count]){
        return NO;
    }
    
    return YES;
}


-(int)getDistanceBetweenPointOne:(CGPoint)one andPointTwo:(CGPoint)two{
    return sqrt(powf(one.x - two.x, 2) + powf(one.y - two.y, 2));
}

@end
