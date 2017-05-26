//
//  DataManager.m
//  week11_3
//
//  Created by viz on 2017. 5. 24..
//  Copyright © 2017년 viz. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

static DataManager *dm;

+ (DataManager*)getSharedDataManager{
    if(dm != nil){
        return dm;
    }
    
    dm = [[DataManager alloc] init];
    
    return dm;
}

// should be called in app delegate
+ (void)initializeWithContext:(NSManagedObjectContext*)context{
    [DataManager getSharedDataManager].managedObjectContext = context;
}

- (NSFetchedResultsController*)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // 여기 찾아보자
    NSFetchRequest *fetchRequest = Student.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

@end
