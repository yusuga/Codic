//
//  NSArray+Codic.m
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "NSArray+Codic.h"

@implementation NSArray (Codic)

- (NSArray *)ys_map:(id (^)(id obj, NSUInteger idx))block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    for (int i = 0; i < [self count]; i++) {
        id value = block([self objectAtIndex:i], i);
        if (value) {
            [array addObject:value];
        }
    };
    return [NSArray arrayWithArray:array];
}

@end
