//
//  TaskGenerator.m
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import "TaskGenerator.h"

#import "Task.h"
#import "NSArray+Random.h"
#import "NSDate+Random.h"


@interface TaskGenerator ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSArray *tasknames;
@property (nonatomic, strong) NSDate *earliestDate;
@property (nonatomic, strong) NSDate *latestDate;

@end


@implementation TaskGenerator

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        _context = context;
        
        _tasknames = @[@"Arma virumque cano",
                       @"Troiae qui",
                       @"primus ab oris",
                       @"Italiam fato",
                       @"profugus Laviniaque",
                       @"venit",
                       @"litora multum ille",
                       @"et terris",
                       @"iactatus et alto",
                       @"vi superum saevae",
                       @" memorem Iunonis",
                       @"ob iram",
                       @"multa quoque",
                       @"et bello passus dum",
                       @"conderet urbem",
                       @"inferretque deos Latio genus",
                       @"unde Latinum",
                       @"Albanique patres",
                       @"atque altae moenia Romae" ];
        
        _earliestDate = [NSDate dateWithTimeIntervalSinceNow:-60 * 30];
        _latestDate = [NSDate date];
    }
    return self;
}

- (NSArray *)generateRandomTasks:(NSInteger)taskCount {
    NSMutableArray *tasks = [NSMutableArray array];
    NSEntityDescription *taskEntity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.context];
    for (NSInteger index = 0; index < taskCount; index++) {
        Task *task = [[Task alloc] initWithEntity:taskEntity insertIntoManagedObjectContext:self.context];
        task.title = self.tasknames.randomObject;
        task.date = [NSDate randomDateInRangeFrom:self.earliestDate to:self.latestDate];
        task.complete = @(NO);
        [tasks addObject:task];
    }
    return [tasks copy];
}

@end
