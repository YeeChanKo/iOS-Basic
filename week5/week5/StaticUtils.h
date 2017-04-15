//
//  StaticUtils.h
//  week5
//
//  Created by viz on 2017. 4. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StaticUtils : NSObject

+(UIImage*)changeDimensions:(UIImage*)image :(int)targetWidth :(int)targetHeight;

+(float)deg2rad:(int)degree;

@end
