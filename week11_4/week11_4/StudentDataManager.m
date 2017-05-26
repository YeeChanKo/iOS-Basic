//
//  DataManager.m
//  week11_4
//
//  Created by viz on 2017. 5. 25..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "StudentDataManager.h"

@implementation StudentDataManager

static NSString *_STUDENT_DATA_CHANGED = @"StudentDataChanged";

+(instancetype)getInstance{
    static id instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+(NSString*)STUDENT_DATA_CHANGED{
    return _STUDENT_DATA_CHANGED;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [[NSNotificationCenter defaultCenter] postNotificationName:StudentDataManager.STUDENT_DATA_CHANGED object:nil userInfo:nil];
}

@end
