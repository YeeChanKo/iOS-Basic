//
//  DataManager.m
//  week11_4
//
//  Created by viz on 2017. 5. 25..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "StudentDataManager.h"

@implementation StudentDataManager

static NSString *_STUDENT_DATA_CHANGED = @"StudentDataChanged";

+(instancetype)getInstance{
    static id instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)createStudentWithName:(NSString*)name student_id:(NSString*)student_id gender:(BOOL)gender grade:(int)grade
{
    // 해당 nsentity로 새로운 객체 만들어서 context에 insert한 다음 해당 managed object를 리턴
    Student *object = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_managedObjectContext];
    [object setName:name];
    [object setStudent_id:student_id];
    [object setGender:gender];
    [object setGrade:grade];
    
    NSError *error = nil;
    if(![_managedObjectContext save:&error]){
        NSLog(@"Failed to save: %@", [error description]);
        abort();
    }
    
    NSLog(@"student object saved");
}

-(void)deleteStudentWithStudentId:(NSString*)student_id
{
    NSArray<Student*> *results = [self retrieveStudentsWithStudentId:student_id];
    for(Student *result in results){
        [_managedObjectContext deleteObject:result];
    }
    
    NSError *error = nil;
    if(![_managedObjectContext save:&error]){
        NSLog(@"Failed to delete: %@", [error description]);
        abort();
    }
    
    NSLog(@"student object deleted");
}

-(NSArray<Student*>*)retrieveStudentsWithStudentId:(NSString*)student_id
{
    NSFetchRequest *fetch = Student.fetchRequest;
    fetch.predicate = [NSPredicate predicateWithFormat:@"student_id == %@", student_id];
    
    NSError *error = nil;
    NSArray<Student*> *result = [_managedObjectContext executeFetchRequest:fetch error:&error];
    if(error){
        NSLog(@"Failed to fetch objects: %@", [error description]);
        abort();
    }
    
    NSLog(@"student objects retrieved");
    
    return result;
}

-(NSFetchedResultsController<Student *> *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<Student *> *fetchRequest = Student.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"student_id" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Student *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"StudentCache"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error: %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

+(NSString*)STUDENT_DATA_CHANGED{
    return _STUDENT_DATA_CHANGED;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [[NSNotificationCenter defaultCenter] postNotificationName:StudentDataManager.STUDENT_DATA_CHANGED object:nil userInfo:nil];
}

@end
