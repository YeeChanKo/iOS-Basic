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
    NSMutableDictionary *manager;
}

- (instancetype)initWithViewController:(ViewController*)viewController
{
    self = [super init];
    if (!self) return nil;
    
    vc = viewController;
    
    _imageArr = [[NSMutableArray alloc] init];
    manager = [[NSMutableDictionary alloc] init];
    
    __block CGFloat locationY = 0;
    
    [[[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"images"] enumerateObjectsUsingBlock:^(NSString *path, NSUInteger idx, BOOL *stop) {
        
        // 높이 확인 위해 이미지 가져오기
        UIImage* img = [UIImage imageWithContentsOfFile:path];
        // 너비 화면에 맞췄을 때의 새로운 높이 계산 -> 실제 set을 때 소수점 자리 없어져서 int로 받아줬다
        int newHeight = vc.deviceMaxWidth/img.size.width*img.size.height;
        
        // nsarray에는 객체만 ㅠㅠ
        // 이미지 이름, 상단 위치, 하단 위치
        NSArray *arr = [NSArray arrayWithObjects:[path lastPathComponent], @(locationY),
                        @(locationY + newHeight), nil];

        [_imageArr addObject:arr];
        
        // accumulate image height
        locationY += newHeight;
    }];
    
    [self setFrame:CGRectMake(0,STATUS_BAR_HEIGHT,vc.deviceMaxWidth,vc.deviceMaxHeight-STATUS_BAR_HEIGHT)];
    self.contentSize = CGSizeMake(vc.deviceMaxWidth, locationY);
    
    return self;
}

-(BOOL)checkIfImageViewExistsAtIndex:(int)x{
    UIImageView *imgView = [manager objectForKey:@(x).stringValue];
    return imgView != nil? YES: NO;
}

-(void)addImageViewAtIndex:(int)x{
    NSArray *arr = [_imageArr objectAtIndex:x];
    UIImage *img = [UIImage imageNamed:
                    [NSString stringWithFormat:@"images/%@",[arr objectAtIndex:0]]];
    
    CGFloat topY = [[arr objectAtIndex:1] floatValue];
    CGFloat bottomY = [[arr objectAtIndex:2] floatValue];
    UIImage *newImg = [ScrollView changeDimensions:img :vc.deviceMaxWidth :bottomY-topY];
    
    UIImageView *imgView = [self createImageViewFromImage:newImg AtX:0 AtY:topY];
    [self addSubview:imgView];
    
    // add imageview forkey as index
    [manager setObject:imgView forKey:@(x).stringValue];
    
    
    NSLog(@"img added at %d!",x);
}

-(void)removeImageViewAtIndex:(int)x{
    UIImageView *imgView = [manager objectForKey:@(x).stringValue];
    imgView.image = nil; // img reference 없애주기
    [manager removeObjectForKey:@(x).stringValue]; // manager reference 지우기
    [imgView removeFromSuperview]; // scrollview에서 detach 해주기
    
    
    NSLog(@"img removed at %d!",x);
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

@end
