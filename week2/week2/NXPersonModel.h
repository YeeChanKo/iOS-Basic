//
//  NXPersonModel.h
//  week2
//
//  Created by viz on 2017. 3. 22..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPersonModel : NSObject
{
    NSMutableArray* persons;
}

- (NSString*)personNameAtIndex:(int)index;
- (NSNumber*)personNumberAtIndex:(int)index;
- (BOOL)isMaleAtIndex:(int)index;
- (NSNumber*)personTeamAtIndex:(int)index;
- (NSDictionary*)getPersonObjectAtIndex:(int)index;

- (void)readPersonsFromFile:(NSString*)path;
+ (NSNumber*)convertNSStringToNSNumber:(NSString*)string;

- (NSString*) findPersonNameByNumber:(NSNumber*)number;
- (NSNumber*) findPersonNumberByName:(NSString*)name;

- (NSArray*) sortedByName;
- (NSArray*) sortedByNumber;
- (NSArray*) sortedByTeam;

- (NSArray*) sortOperatorWithKey:(NSString*)key;

- (NSDictionary*)findDictionaryWithKeyValue:(NSString*)key forValue:(NSString *)value;

@end
