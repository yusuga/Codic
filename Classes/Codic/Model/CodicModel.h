//
//  CodicModel.h
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodicModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, readonly) NSDictionary *dictionary;

@end
