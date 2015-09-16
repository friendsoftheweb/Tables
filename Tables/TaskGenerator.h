//
//  TaskGenerator.h
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface TaskGenerator : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

/// Generates a given number of random tasks and inserts them in to the receiver's context.
- (NSArray *)generateRandomTasks:(NSInteger)taskCount;

@end
