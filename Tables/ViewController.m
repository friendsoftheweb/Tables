//
//  ViewController.m
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import "ViewController.h"

@import CoreData;
#import "Task.h"
#import "TaskGenerator.h"


@interface ViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSFetchedResultsController *tasksController;
@property (nonatomic, strong, readonly) TaskGenerator *taskGenerator;

@end


@implementation ViewController
@synthesize taskGenerator = _taskGenerator;


- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _context = context;
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
        fetchRequest.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"complete" ascending:YES],
                                         [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]
                                         ];
        _tasksController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:@"cache"];
        _tasksController.delegate = self;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Insert" style:UIBarButtonItemStylePlain target:self action:@selector(insertRandomTasks:)];
        
        self.title = @"Tasks";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tasksController performFetch:nil];
}


#pragma mark - Actions

- (IBAction)insertRandomTasks:(id)sender {
    [self.taskGenerator generateRandomTasks:3];
}


#pragma mark - <UITableViewDataSource>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.tasksController.sections[sectionIndex];
    return sectionInfo.numberOfObjects;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tasksController.sections.count;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Task *task = [self.tasksController objectAtIndexPath:indexPath];
    [task toggleCompletion];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.context save:nil];
}


#pragma mark - <NSFetchedResultsControllerDelegate>

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    NSString *typeString = @"";
    if (type == NSFetchedResultsChangeInsert) {
        typeString = @"Insert: ";
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeDelete) {
        typeString = @"Delete: ";
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeUpdate) {
        typeString = @"Update: ";
        [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeMove) {
        typeString = @"Move:   ";
        [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    }
    NSLog(@"%@ %@ -> %@", typeString, [self stringForIndexPath:indexPath], [self stringForIndexPath:newIndexPath]);
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSLog(@"%@: %p; %@", NSStringFromClass([self class]), self, NSStringFromSelector(_cmd));
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}



#pragma mark - Private

- (TaskGenerator *)taskGenerator {
    if (!_taskGenerator) {
        NSAssert(self.context != nil, @"%@ expected a context before invoking %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
        _taskGenerator = [[TaskGenerator alloc] initWithManagedObjectContext:self.context];
    }
    return _taskGenerator;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Task *task = [self.tasksController objectAtIndexPath:indexPath];
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:task.date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
    cell.textLabel.textColor = task.complete.boolValue ? [UIColor lightGrayColor] : [UIColor blackColor];
    cell.detailTextLabel.textColor = task.complete.boolValue ? [UIColor lightGrayColor] : [UIColor blackColor];
}

- (NSString *)stringForIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) {
        return @"(null)";
    }
    NSAssert(indexPath.length == 2, @"");
    return [NSString stringWithFormat:@"{%@ - %@}", @(indexPath.section), @(indexPath.row)];
}


@end
