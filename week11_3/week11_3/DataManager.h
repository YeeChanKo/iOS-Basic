//
//  DataManager.h
//  week11_3
//
//  Created by viz on 2017. 5. 24..
//  Copyright © 2017년 viz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Student+CoreDataClass.h"
#import <UIKit/UIKit.h>

@interface DataManager : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

+ (DataManager*)getSharedDataManager;
+ (void)initializeWithContext:(NSManagedObjectContext*)context;
- (void)insertNewStudent:(Student*)student;

// fetched result controller 당 객체 하나

@end
