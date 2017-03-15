//
//  main.m
//  week1-2
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXFileMatcher.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [NXFileMatcher initSingleton];
        //[NXFileMatcher displayAllFilesAtPath:@"/Users/viz/Downloads"];
        [NXFileMatcher displayAllFilesAtPath:@"/Users/viz/Downloads" filterByExtension:@"png"];
    }
    return 0;
}
