//
//  NXPersonModel.m
//  week2
//
//  Created by viz on 2017. 3. 22..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "NXPersonModel.h"

@implementation NXPersonModel

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    return self;
}

- (NSString*)personNameAtIndex:(int)index;
{
    return [persons[index] objectForKey:@"name"];
}

- (NSNumber*)personNumberAtIndex:(int)index;
{
    return [persons[index] objectForKey:@"number"];
}

- (BOOL)isMaleAtIndex:(int)index;
{
    return [[persons[index] objectForKey:@"sex"] isEqualToString:@"M"]? YES : NO;
}

- (NSNumber*)personTeamAtIndex:(int)index;
{
    return [persons[index] objectForKey:@"team"];
}

- (NSDictionary*)getPersonObjectAtIndex:(int)index;
{
    return persons[index];
}

- (void)readPersonsFromFile:(NSString*)path;
{
    persons = [[NSMutableArray alloc] init];
    
    NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    for (NSString* line in [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]])
    {
        //        NSLog(@"%@", line);
        
        NSArray* splits = [line componentsSeparatedByString:@","];
        
        //        NSLog(@"%@,%@,%@,%@",splits[0],splits[1],splits[2],splits[3]);
        
        NSNumber* number = [NXPersonModel convertNSStringToNSNumber:splits[1]];
        NSNumber* team = [NXPersonModel convertNSStringToNSNumber:splits[3]];
        
        NSDictionary* person = @{@"name" : splits[0],
                                 @"number" : number,
                                 @"sex" : splits[2],
                                 @"team" : team};
        [persons addObject:person];
    }
}

+ (NSNumber*)convertNSStringToNSNumber:(NSString*)string;
{
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f numberFromString:string];
    // numberformatter release 어떻게 하지?
}

- (NSString*) findPersonNameByNumber:(NSNumber*)number;
{
    NSDictionary* foundDic = [self findDictionaryWithKeyValue:@"number" forValue:[number stringValue]];
    return [foundDic objectForKey:@"name"];
}

- (NSNumber*) findPersonNumberByName:(NSString*)name;
{
    NSDictionary* foundDic = [self findDictionaryWithKeyValue:@"name" forValue:name];
    return [foundDic objectForKey:@"number"];
}

- (NSDictionary*)findDictionaryWithKeyValue:(NSString*)key forValue:(NSString *)value;
{
    
    NSNumber* nsNumberValue = nil;
    if([key isEqualToString:@"number"] || [key isEqualToString:@"team"])
        nsNumberValue = [NXPersonModel convertNSStringToNSNumber:value];
    
    for(NSDictionary* dic in persons)
        if([[dic objectForKey:key] isEqual:value])
            return dic;
    
    return nil;
}

- (NSArray*) sortedByName;
{
    return [self sortOperatorWithKey:@"name"];
}

- (NSArray*) sortedByNumber;
{
    return [self sortOperatorWithKey:@"number"];
}

- (NSArray*) sortedByTeam;
{
    return [self sortOperatorWithKey:@"team"];
}

- (NSArray*) sortOperatorWithKey:(NSString*)key;
{
    NSArray* sortedArray;
    sortedArray = [persons sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        NSObject* first = [a objectForKey:key];
        NSObject* second = [b objectForKey:key];
        // 이 부분 무슨 타입인지 iskindofclass, 타입추측
        if([key isEqualToString:@"number"] || [key isEqualToString:@"team"])
        {
            return [(NSNumber*)first compare:(NSNumber*)second];
        }
        else{
            return [(NSString*)first compare:(NSString*)second];
        }
    }];
    
    return sortedArray;
}

@end
