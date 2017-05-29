//
//  DataManager.h
//  week11_4
//
//  Created by viz on 2017. 5. 25..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student+CoreDataClass.h"

@interface StudentDataManager : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic, class, readonly) NSString *STUDENT_DATA_CHANGED;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController<Student*> *fetchedResultsController;

+(instancetype)getInstance;
-(void)createStudentWithName:(NSString*)name student_id:(NSString*)student_id gender:(BOOL)gender grade:(int)grade;
-(NSArray<Student*>*)retrieveStudentsWithStudentId:(NSString*)student_id;
-(void)deleteStudentWithStudentId:(NSString*)student_id;

@end
