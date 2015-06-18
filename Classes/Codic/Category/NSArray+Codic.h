//
//  NSArray+Codic.h
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Codic)

- (NSArray *)ys_map:(id (^)(id obj, NSUInteger idx))block;

@end
