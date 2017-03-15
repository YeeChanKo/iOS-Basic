//
//  main.m
//  week1
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"
#import "NXPenHolder.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NXPenHolder *penHolder = [[NXPenHolder alloc] initWithCapacity:5];
        
        NXPen *pen1 = [[NXPen alloc] initWithBrand:@"monami"];
        [pen1 setColor:@"red"];
        [pen1 setUsage:95];
        [penHolder add:pen1];
        [penHolder add:pen1];
        [penHolder printDescription];
        
        NXPen *pen2 = [[NXPen alloc] initWithBrand:@"sharp"];
        [pen2 setColor:@"black"];
        [pen2 setUsage:30];
        [penHolder add:pen2];
        [penHolder printDescription];
        
        NXPen *pen3 = [[NXPen alloc] initWithBrand:@"monami"];
        [pen3 setColor:@"blue"];
        [pen3 setUsage:50];
        [penHolder add:pen3];
        [penHolder printDescription];
        
        [penHolder remove:10];
        [penHolder printDescription];
        [penHolder remove:3];
        [penHolder printDescription];
    }
    return 0;
}
