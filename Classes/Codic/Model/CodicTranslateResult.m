//
//  CodicTranslateResult.m
//  Codic
//
//  Created by Yu Sugawara on 6/21/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CodicTranslateResult.h"

@implementation CodicTranslateResult

- (NSDictionary *)data
{
    return self.dictionary[@"data"];
}

- (CodicTranslation *)translation
{    
    return [[CodicTranslation alloc] initWithDictionary:[[self data][@"translation"] firstObject][@"translation"]];
}

@end

@implementation CodicTranslation

- (BOOL)successful
{
    return [self.dictionary[@"successful"] boolValue];
}

- (NSInteger)id
{
    return [self.dictionary[@"id"] integerValue];
}

- (NSString *)text
{
    return self.dictionary[@"text"];
}

- (NSString *)translatedText
{
    return self.dictionary[@"translatedText"];
}

- (NSString *)translatedWithCasing
{
    return self.dictionary[@"translatedWithCasing"];
}

- (NSArray *)phrases
{
    return self.dictionary[@"phrases"];
}

@end