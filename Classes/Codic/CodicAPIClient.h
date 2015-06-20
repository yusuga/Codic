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

typedef void (^CodicAPIClientRequestSearchCompletion)(AFHTTPRequestOperation *operation, CodicSearchResult *result, NSError *error);
typedef void (^CodicAPIClientRequestTranslateCompletion)(AFHTTPRequestOperation *operation, CodicTranslateResult *result, NSError *error);

@interface CodicAPIClient : NSObject

+ (instancetype)sharedClient;

- (AFHTTPRequestOperation *)requestSearchWithQuery:(NSString *)query
                                        completion:(CodicAPIClientRequestSearchCompletion)completion;

- (AFHTTPRequestOperation *)requestTranslateWithQuery:(NSString *)query
                                           completion:(CodicAPIClientRequestTranslateCompletion)completion;

@end
