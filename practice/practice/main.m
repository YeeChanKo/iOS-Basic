//
//  main.m
//  practice
//
//  Created by viz on 2017. 5. 9..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    }
    return 0;
}

void dictionaryAsKeyTest(){
    NSMutableDictionary *dic = [@{} mutableCopy];
    NSDictionary *test1 = @{@(1): @"hello", @"key": @"value"};
    NSDictionary *test2 = @{@(1): @"hello", @"key": @"value"};
    [dic setObject:@"really?" forKey:test1];
    NSString *expected = [dic objectForKey:test2];
    NSLog(@"%@", expected);
}
