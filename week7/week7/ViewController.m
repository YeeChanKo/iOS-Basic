//
//  ViewController.m
//  week7
//
//  Created by viz on 2017. 4. 26..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "ViewController.h"
#import "ScrollView.h"

@implementation ViewController{
    ScrollView *scrollView;
    
    int firstImageOfShownIndex;
    int lastImageOfShownIndex;
    
    CGFloat lastTopY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _deviceMaxWidth = CGRectGetMaxX(self.view.bounds);
    _deviceMaxHeight = CGRectGetMaxY(self.view.bounds);
    
    scrollView = [[ScrollView alloc] initWithViewController:self];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    lastTopY = 0;
    firstImageOfShownIndex = 0;
    [self displayImageAfter:0 :_deviceMaxHeight - STATUS_BAR_HEIGHT];
}

-(void)scrollViewDidScroll:(UIScrollView *)sv{
    CGFloat currentTopY = sv.contentOffset.y;
    CGFloat currentBottomY = currentTopY + _deviceMaxHeight - STATUS_BAR_HEIGHT;
    
    if(currentTopY > lastTopY){
        //scroll down
        [self displayImageAfter:currentTopY :currentBottomY];
    }else{
        //scroll up
        [self displayImageBefore:currentTopY :currentBottomY];
    }
    
    lastTopY = currentTopY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayImageAfter:(CGFloat)topY :(CGFloat)bottomY {
    BOOL checkFirst = NO;
    for(int i = firstImageOfShownIndex; i < [scrollView.imageArr count] ; i++){
        NSArray *arr = [scrollView.imageArr objectAtIndex:i];
        CGFloat locationTop = [[arr objectAtIndex:1] floatValue];
        CGFloat locationBottom = [[arr objectAtIndex:2] floatValue];
        
        // 수가 낮아야 더 높이 있는 거임
        // 사진의 하단 locbot는 화면의 상단 topy보다 커야 함 (아래 있어야 함)
        // 사진의 상단 loctop은 화면의 하단 boty보다 작아야 함 (위에 있어야 함)
        if(locationBottom > topY && locationTop < bottomY){
            if(checkFirst == NO){
                // 앞에서 첫번째로 화면에 나타나는 녀석
                checkFirst = YES; // flag 바꿔줌
                firstImageOfShownIndex = i; // 인덱스 저장
            }
            
            // 없으면 추가, 있으면 아무것도 안함
            if(![scrollView checkIfImageViewExistsAtIndex:i]){
                [scrollView addImageViewAtIndex:i];
            }
        }else{
            if(checkFirst == NO){
                // 메모리 해제
                // 앞에 있었는데 이제는 안 나오는 것들
                [scrollView removeImageViewAtIndex:i];
            }else{
                // 뒤에 있지만 화면에 나타나지 않는 것
                lastImageOfShownIndex = i - 1;
                break; // 더 이상 할 필요 없음 for문 탈출
            }
        }
    }
}

- (void)displayImageBefore:(CGFloat)topY :(CGFloat)bottomY {
    BOOL checkLast = NO;
    for(int i = lastImageOfShownIndex; i >= 0 ; i--){
        NSArray *arr = [scrollView.imageArr objectAtIndex:i];
        CGFloat locationTop = [[arr objectAtIndex:1] floatValue];
        CGFloat locationBottom = [[arr objectAtIndex:2] floatValue];
        
        if(locationBottom > topY && locationTop < bottomY){
            if(checkLast == NO){
                // 뒤에서 첫번째로 화면에 나타나는 녀석
                checkLast = YES; // flag 바꿔줌
                lastImageOfShownIndex = i; // 인덱스 저장
            }
            
            // 없으면 추가, 있으면 아무것도 안함
            if(![scrollView checkIfImageViewExistsAtIndex:i]){
                [scrollView addImageViewAtIndex:i];
            }
        }else{
            if(checkLast == NO){
                // 메모리 해제
                // 뒤에 있었는데 이제는 안 나오는 것들
                [scrollView removeImageViewAtIndex:i];
            }else{
                // 앞에 있지만 화면에 나타나지 않는 것
                firstImageOfShownIndex = i + 1;
                break; // 더 이상 할 필요 없음 for문 탈출
            }
        }
    }
}

@end
