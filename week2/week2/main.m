//
//  main.m
//  week2
//
//  Created by viz on 2017. 3. 22..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPersonModel.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NXPersonModel* test = [[NXPersonModel alloc] init];
        [test readPersonsFromFile:@"/Users/viz/persons.txt"];
        
        for(int i=0;i<8;i++)
        {
            NSLog(@"name: %@",[test personNameAtIndex:i]);
            NSLog(@"number: %@",[test personNumberAtIndex:i]);
            NSLog(@"ismale: %hhd",[test isMaleAtIndex:i]);
            NSLog(@"team: %@",[test personTeamAtIndex:i]);
            NSLog(@"object: %@",[test getPersonObjectAtIndex:i]);
        }
        
        
        NSLog(@"findPersonNameByNumber: %@", [test findPersonNameByNumber:[NSNumber numberWithInt:121009]]);
        NSLog(@"findPersonNumberByName: %@", [test findPersonNumberByName:@"전지현"]);
        
        NSLog(@"sortedByName: %@", [test sortedByName]);
        NSLog(@"sortedByNumber: %@", [test sortedByNumber]);
        NSLog(@"sortedByTeam: %@", [test sortedByTeam]);
        
    }
    return 0;
}
