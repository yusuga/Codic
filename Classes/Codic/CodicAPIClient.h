//
//  CodicAPIClient.h
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "CodicModels.h"

typedef void (^CodicAPIClientRequestCEDSearchCompletion)(AFHTTPRequestOperation *operation, CodicCEDSearchResult *result, NSError *error);

@interface CodicAPIClient : NSObject

+ (instancetype)sharedClient;

- (AFHTTPRequestOperation *)requestCEDSearchWithQuery:(NSString *)query
                                           completion:(CodicAPIClientRequestCEDSearchCompletion)completion;

@end
