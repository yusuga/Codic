//
//  CodicModel.m
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CodicModel.h"

@interface CodicModel ()

@property (nonatomic, readwrite) NSDictionary *dictionary;

@end

@implementation CodicModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (![dictionary isKindOfClass:[NSDictionary class]]) return nil;
    
    if (self = [super init]) {
        self.dictionary = dictionary;
    }
    return self;
}

@end
