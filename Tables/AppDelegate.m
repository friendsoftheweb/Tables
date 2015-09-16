//
//  AppDelegate.m
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import "AppDelegate.h"

@import CoreData;

#import "ViewController.h"


@interface AppDelegate ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


@implementation AppDelegate
@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Tables" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    [self.persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    NSAssert(self.managedObjectContext, @"Failed to Setup Context");
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIViewController *tasksViewController = [[ViewController alloc] initWithManagedObjectContext:self.managedObjectContext];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:tasksViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
