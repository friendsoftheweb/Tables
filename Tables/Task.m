//
//  Task.m
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import "Task.h"

@implementation Task

- (void)toggleCompletion {
    self.complete = [self.complete boolValue] ? @(NO) : @(YES);
}

@end
