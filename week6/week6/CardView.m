//
//  CardView.m
//  week6
//
//  Created by viz on 2017. 4. 19..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _cardImages = [[NSMutableDictionary alloc] init];
    [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"card_decks"] enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL *stop) {
        
        UIImage* cardImage = [CardView changeDimensions:[UIImage imageWithContentsOfFile:path] :CARD_WIDTH :CARD_HEIGHT];
        [_cardImages setObject:cardImage forKey:[path lastPathComponent]];
    }];
    
    return self;
}

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

@end
