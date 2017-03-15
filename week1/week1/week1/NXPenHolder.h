//
//  NXPenHolder.h
//  week1
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"

@interface NXPenHolder : NSObject
{
    NSMutableArray* _pens;
    int _capacity;
    int _usage;
}

-(id)initWithCapacity:(int)capacity;

-(void)add:(NXPen*)pen;
-(void)remove:(int)penIndex;
-(int)usage;

-(void)printDescription;

@end
