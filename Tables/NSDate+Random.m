//
//  NSDate+Random.m
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import "NSDate+Random.h"

@implementation NSDate (Random)

+ (NSDate *)randomDateInRangeFrom:(NSDate *)fromDate to:(NSDate *)endDate {
    NSAssert([endDate timeIntervalSinceDate:fromDate] > 0, @"%@ expects from date to be earlier than end date", NSStringFromSelector(_cmd));
    NSTimeInterval totalInterval = [endDate timeIntervalSinceDate:fromDate];
    NSTimeInterval randomInterval = arc4random_uniform(totalInterval);
    return [fromDate dateByAddingTimeInterval:randomInterval];
}

@end
