//
//  CodicSearchResult.m
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CodicSearchResult.h"
#import "NSArray+Codic.h"

@implementation CodicSearchResult
{
    NSArray *_data;
}

- (NSString *)status
{
    return self.dictionary[@"status"];
}

- (NSArray *)data
{
    if (!_data) {
        _data = [self.dictionary[@"data"] ys_map:^id(id obj, NSUInteger idx) {
            return [[CodicSearch alloc] initWithDictionary:obj];
        }];
    }
    return _data;
}

@end

@implementation CodicSearch

- (NSInteger)id
{
    return [self.dictionary[@"id"] integerValue];
}

- (NSString *)title
{
    return self.dictionary[@"title"];
}

- (NSString *)digest
{
    return self.dictionary[@"digest"];
}

- (BOOL)published
{
    return [self.dictionary[@"published"] boolValue];
}

- (BOOL)isRedirect
{
    return [self.dictionary[@"isRedirect"] boolValue];
}

- (NSString *)redirectTo
{
    return self.dictionary[@"redirectTo"];
}

@end