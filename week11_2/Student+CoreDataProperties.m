//
//  Student+CoreDataProperties.m
//  week11_2
//
//  Created by viz on 2017. 5. 24..
//  Copyright © 2017년 viz. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic id;
@dynamic name;
@dynamic gender;
@dynamic grade;

@end
