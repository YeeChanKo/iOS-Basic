//
//  Student+CoreDataProperties.h
//  week11_2
//
//  Created by viz on 2017. 5. 24..
//  Copyright © 2017년 viz. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL gender;
@property (nonatomic) int16_t grade;

@end

NS_ASSUME_NONNULL_END
