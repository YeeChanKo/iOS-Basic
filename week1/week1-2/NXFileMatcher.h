//
//  NXFileMatcher.h
//  week1-2
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSFileManager* _nsFilemanager;

@interface NXFileMatcher : NSObject

+(void)initSingleton;

+(void)displayAllFilesAtPath:(NSString*)path;

+(void)displayAllFilesAtPath:(NSString *)path filterByExtension:(NSString*)extension;

@end
