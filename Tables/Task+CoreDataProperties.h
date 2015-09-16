//
//  Task+CoreDataProperties.h
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *complete;

@end

NS_ASSUME_NONNULL_END
