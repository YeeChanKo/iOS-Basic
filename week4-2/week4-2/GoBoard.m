//
//  GoBoard.m
//  week4-2
//
//  Created by viz on 2017. 4. 5..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "GoBoard.h"
#include <CoreGraphics/CGGeometry.h>

@implementation GoBoard

-(void)clear
{
    memset(board, 0, sizeof(board[0][0]) * LINE_COUNT * LINE_COUNT);
    memset(graph, 0, sizeof(graph[0][0]) * LINE_COUNT * 3);
}

-(void)addStoneAtX:(int)x Y:(int)y Color:(int)color
{
    board[x][y] = color;
}

-(void)stackOnGraphAtColumnX:(int)x Color:(int)color
{
    graph[x][color]++;
}

-(int)calculateAndGetMostColoredOnColumnX:(int)x
{
    int blackStones = graph[x][BLACK_STONE];
    int whiteStones = graph[x][WHITE_STONE];
    
    if(blackStones > whiteStones){
        graph[x][0] = blackStones;
        return BLACK_STONE;
    } else if (whiteStones > blackStones){
        graph[x][0] = whiteStones;
        return WHITE_STONE;
    } else {
        return 0;
    }
}

-(int)getCountOfMostColoredOnColumnX:(int)x
{
    return graph[x][0];
}

-(BOOL)decideBoxOfTouchAndAddWithX:(float)x Y:(float)y
{
    _touchedBoxX = x/_boxWidth;
    _touchedBoxY = (y-MARGIN_TOP)/_boxWidth;
    
    NSLog(@"%d, %d", _touchedBoxX, _touchedBoxY);
    
    // 바둑판 밖의 값일 경우 제외
    if(_touchedBoxX > LINE_COUNT-1 || _touchedBoxY > LINE_COUNT-1){
        return NO;
    }
    
    if(![self checkIfExistAtX:_touchedBoxX Y:_touchedBoxY]){
        [self addStoneAtX:_touchedBoxX Y:_touchedBoxY Color:_turnChecker]; // turnChecker 값이 바로 당시 놓여지는 차례의 색
        [self stackOnGraphAtColumnX:_touchedBoxX Color:_turnChecker];
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)checkIfExistAtX:(int)x Y:(int)y
{
    if(board[x][y] == BLACK_STONE || board[x][y] == WHITE_STONE)
        return YES;
    else
        return NO;
}

-(CGRect)makeRectOfStoneFromLastTouch
{
    return CGRectMake(_boxWidth*_touchedBoxX, MARGIN_TOP+_boxWidth*_touchedBoxY, _boxWidth, _boxWidth);
}



@end
