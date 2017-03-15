//
//  NXFileMatcher.m
//  week1-2
//
//  Created by viz on 2017. 3. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "NXFileMatcher.h"

@implementation NXFileMatcher

+(void)initSingleton;
{
    _nsFilemanager = [NSFileManager defaultManager];
}

+(void)displayAllFilesAtPath:(NSString*)path;
{
    NSError* error;
    NSArray* filesAndFolders = [_nsFilemanager contentsOfDirectoryAtPath:path error:&error];
    if(error)
        NSLog(@"%@",error);
    else
        for(NSString* fileAndFolder in filesAndFolders)
            NSLog(@"%@",fileAndFolder);
}

+(void)displayAllFilesAtPath:(NSString *)path filterByExtension:(NSString*)extension;
{
    NSError* error;
    NSArray* filesAndFolders = [_nsFilemanager contentsOfDirectoryAtPath:path error:&error];
    if(error)
        NSLog(@"%@",error);
    else
    {
        NSString *regex = [NSString stringWithFormat:@".*\\.%@$", extension];
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        for(NSString* fileAndFolder in filesAndFolders)
            if([test evaluateWithObject:fileAndFolder])
                NSLog(@"%@",fileAndFolder);
    }
}


@end
