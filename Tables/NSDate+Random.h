//
//  NSDate+Random.h
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Random)

+ (NSDate *)randomDateInRangeFrom:(NSDate *)fromDate to:(NSDate *)endDate;

@end
