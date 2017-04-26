//
//  ScrollView.m
//  week7
//
//  Created by viz on 2017. 4. 26..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView{
    ViewController *vc;
}

- (instancetype)initWithViewController:(ViewController*)viewController
{
    self = [super init];
    if (!self) return nil;
    
    vc = viewController;
    
    _imageArr = [[NSMutableArray alloc] init];
    
    __block CGFloat locationY = 0;
    
    [[[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"images"] enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL *stop) {
        
        // change image dimensions
        UIImage* img = [UIImage imageWithContentsOfFile:path];
        CGFloat newHeight = vc.deviceMaxWidth/img.size.width*img.size.height;
        UIImage* newImg = [ScrollView changeDimensions:img :vc.deviceMaxWidth :newHeight];
        
        CGFloat newHeightSet = newImg.size.height;
        
        // nsarray에는 객체만 ㅠㅠ
        // add image, imgTopLocation, imgBottomLocation to image array
        NSArray *arr = [NSArray arrayWithObjects:newImg, @(locationY),
                        @(locationY + newHeightSet), nil];

        [_imageArr addObject:arr];
        
        // accumulate image height
        locationY += newImg.size.height;
    }];
    
    [self setFrame:CGRectMake(0,STATUS_BAR_HEIGHT,vc.deviceMaxWidth,vc.deviceMaxHeight-STATUS_BAR_HEIGHT)];
    self.contentSize = CGSizeMake(vc.deviceMaxWidth, locationY);
    
    return self;
}

-(void)addImageViewAtIndex:(int)x{
    NSArray *arr = [_imageArr objectAtIndex:x];
    UIImage *img = [arr objectAtIndex:0];
    CGFloat locationY = [[arr objectAtIndex:1] floatValue];
    [self addSubview:[self createImageViewFromImage:img AtX:0 AtY:locationY]];
}

-(UIImageView*)createImageViewFromImage:(UIImage*)img AtX:(float)x AtY:(float)y
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:
                            CGRectMake(x, y, img.size.width, img.size.height)];
    imgView.image = img;
    return imgView;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
