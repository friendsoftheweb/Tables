//
//  NSArray+Random.m
//  Tables
//
//  Created by Anthony Mattox on 9/16/15.
//  Copyright © 2015 Friends of The Web. All rights reserved.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

- (id)randomObject {
    if (self.count) {
        return [self objectAtIndex:arc4random_uniform((uint32_t) self.count)];
    }
    return nil;
}

@end
