//
//  GoView.m
//  week4-2
//
//  Created by viz on 2017. 4. 5..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "GoView.h"
#import "GoBoard.h"

@implementation GoView
{
    UIImage *blackStone;
    UIImage *whiteStone;
    
    GoBoard *goBoard;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self];
    
    if([goBoard decideBoxOfTouchAndAddWithX:location.x Y:location.y]){
        if(goBoard.turnChecker == BLACK_STONE){
            [self drawBlackStoneFromLastTouch];
            goBoard.turnChecker = WHITE_STONE;
        }else if(goBoard.turnChecker == WHITE_STONE){
            [self drawWhiteStoneFromLastTouch];
            goBoard.turnChecker = BLACK_STONE;
        }
        
        [self setNeedsDisplay];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [goBoard clear];
        [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        goBoard.turnChecker = BLACK_STONE;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    goBoard = [[GoBoard alloc] init];
    goBoard.deviceMaxX = CGRectGetMaxX(self.bounds);
    goBoard.deviceMaxY = CGRectGetMaxY(self.bounds);
    
    goBoard.boxWidth = goBoard.deviceMaxX/11;
    goBoard.boxHalfWidth = goBoard.boxWidth/2;
    
    blackStone=[self changeDimensions:[UIImage imageNamed:@"black.png"]];
    whiteStone=[self changeDimensions:[UIImage imageNamed:@"white.png"]];
    
    goBoard.turnChecker = BLACK_STONE;
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"draw rect initiated");
    [self drawLine];
    [self drawGraph];
}

-(void)drawBlackStoneFromLastTouch
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:[goBoard makeRectOfStoneFromLastTouch]];
    imgView.image = blackStone;
    [self addSubview:imgView];
}

-(void)drawWhiteStoneFromLastTouch
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:[goBoard makeRectOfStoneFromLastTouch]];
    imgView.image = whiteStone;
    [self addSubview:imgView];
}

-(UIImage*)changeDimensions:(UIImage*)image
{
    UIGraphicsBeginImageContext(CGSizeMake(goBoard.boxWidth, goBoard.boxWidth));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, goBoard.boxWidth);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, goBoard.boxWidth, goBoard.boxWidth), [image CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)drawLine
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    int countOfBoxHalfWidth = LINE_COUNT * 2 - 1;
    for(int i = 1; i <= countOfBoxHalfWidth ; i += 2)
    {
        // 수직 방향 선
        CGPoint startPoint1 = [self makeLinePointWithX:i Y:1];
        CGPoint endPoint1 = [self makeLinePointWithX:i Y:countOfBoxHalfWidth];
        [path moveToPoint:startPoint1];
        [path addLineToPoint:endPoint1];
        
        // 수평 방향 선
        CGPoint startPoint2 = [self makeLinePointWithX:1 Y:i];
        CGPoint endPoint2 = [self makeLinePointWithX:countOfBoxHalfWidth Y:i];
        [path moveToPoint:startPoint2];
        [path addLineToPoint:endPoint2];
    }
    [path stroke];
}

-(void)drawGraph
{
    NSLog(@"draw graph started");
    
    
    for(int x = 0; x < LINE_COUNT; x++){
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        int color = [goBoard calculateAndGetMostColoredOnColumnX:x];
        int count = [goBoard getCountOfMostColoredOnColumnX:x];
        
        CGPoint startPoint = [self makeGraphPointBottomWithX:x];
        CGPoint endPoint = [self makeGraphPointTopWithX:x Y:count];
        
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
        [path setLineWidth:goBoard.boxWidth-GRAPH_WIDTH_SPACE];
        
        switch(color){
            case 0:
                [[UIColor clearColor] setStroke];
                break;
            case BLACK_STONE:
                [[UIColor blackColor] setStroke];
                break;
            case WHITE_STONE:
                [[UIColor whiteColor] setStroke];
                break;
        }
        
        [path stroke];
    }
}

-(CGPoint)makeLinePointWithX:(int)boxHalfWidthCountX Y:(int)boxHalfWidthCountY
{
    return CGPointMake(goBoard.boxHalfWidth*boxHalfWidthCountX,MARGIN_TOP+goBoard.boxHalfWidth*boxHalfWidthCountY);
}

-(CGPoint)makeStonePointWithX:(int)boxCountX Y:(int)boxCountY
{
    return CGPointMake(goBoard.boxWidth*boxCountX,MARGIN_TOP+goBoard.boxWidth*boxCountY);
}

-(CGPoint)makeGraphPointBottomWithX:(int)boxCountX
{
    return CGPointMake(goBoard.boxHalfWidth+goBoard.boxWidth*boxCountX,goBoard.deviceMaxY);
}

-(CGPoint)makeGraphPointTopWithX:(int)boxCountX Y:(int)count
{
    return CGPointMake(goBoard.boxHalfWidth+goBoard.boxWidth*boxCountX,goBoard.deviceMaxY-count*GRAPH_HEIGHT_PER_COUNT);
}

@end
