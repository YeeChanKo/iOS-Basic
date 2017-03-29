//
//  MyModel.h
//  week3-2
//
//  Created by viz on 2017. 3. 29..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
@property NSArray* nsArrayFromJson;
@property int randomNumber;

- (instancetype)init;
- (NSDictionary*)itemAtIndex:(int)index;
- (int)getIndexCountOfArray;

@end
