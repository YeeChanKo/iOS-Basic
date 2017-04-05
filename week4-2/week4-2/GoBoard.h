//
//  GoBoard.h
//  week4-2
//
//  Created by viz on 2017. 4. 5..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreGraphics/CGGeometry.h>

#define LINE_COUNT 11
#define BLACK_STONE 1
#define WHITE_STONE 2
#define MARGIN_TOP 20
#define GRAPH_HEIGHT_PER_COUNT 20
#define GRAPH_WIDTH_SPACE 5

@interface GoBoard : NSObject
{
    int board[LINE_COUNT][LINE_COUNT];
    // 0값은 빈공간, 1값은 검은돌, 2값은 흰돌
    int graph[LINE_COUNT][3];
    // [11][1]은 검은돌 개수, [11][2]은 흰돌 개수
    // [11][0]은 더 많은 색 돌의 개수
}

@property float deviceMaxX;
@property float deviceMaxY;

@property float boxWidth;
@property float boxHalfWidth;

@property int touchedBoxX;
@property int touchedBoxY;

@property int turnChecker;

-(void)clear;

-(void)addStoneAtX:(int)x Y:(int)y Color:(int)color;

-(void)stackOnGraphAtColumnX:(int)x Color:(int)color;

-(int)calculateAndGetMostColoredOnColumnX:(int)x;

-(int)getCountOfMostColoredOnColumnX:(int)x;

-(BOOL)decideBoxOfTouchAndAddWithX:(float)x Y:(float)y;

-(BOOL)checkIfExistAtX:(int)x Y:(int)y;

-(CGRect)makeRectOfStoneFromLastTouch;

@end
