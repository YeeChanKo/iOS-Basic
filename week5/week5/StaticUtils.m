//
//  StaticUtils.m
//  week5
//
//  Created by viz on 2017. 4. 15..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "StaticUtils.h"

@implementation StaticUtils

+(UIImage*)changeDimensions:(UIImage*)image :(int)targetWidth :(int)targetHeight
{
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, targetHeight);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, targetWidth, targetHeight), [image CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(float)deg2rad:(int)degree
{
    return (double)degree * M_PI / 180;
}

@end
