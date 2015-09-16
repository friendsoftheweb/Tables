//
//  Task.h
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSManagedObject

- (void)toggleCompletion;

@end

NS_ASSUME_NONNULL_END

#import "Task+CoreDataProperties.h"
