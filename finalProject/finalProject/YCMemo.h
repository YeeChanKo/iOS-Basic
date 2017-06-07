//
//  YCMemo.h
//  finalProject
//
//  Created by viz on 2017. 6. 7..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"

@interface YCMemo : RLMObject

@property NSString *uuid;
@property NSString *content;
@property NSString *author;
@property NSDate *date;

-(void)save;

@end
