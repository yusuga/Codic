//
//  CodicAPIClient.m
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CodicAPIClient.h"

static NSString * kCodicBaseURL = @"https://codic.jp";

static NSString * kCodicSearchURL = @"/-/ced/search.json";

typedef void (^CodicAPIClientRequestCompletion)(AFHTTPRequestOperation *operation, id responseObject, NSError *error);

@interface CodicAPIClient ()

@property (nonatomic) AFHTTPRequestOperationManager *client;

@end

@implementation CodicAPIClient

+ (instancetype)sharedClient
{
    static id __instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance =  [[self alloc] init];
    });
    return __instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.client = [AFHTTPRequestOperationManager manager];
        
        AFJSONResponseSerializer *serializer =[AFJSONResponseSerializer serializer];
        serializer.removesKeysWithNullValues = YES;
        self.client.responseSerializer = serializer;
    }
    return self;
}

- (AFHTTPRequestOperation *)requestCEDSearchWithQuery:(NSString *)query
                                           completion:(CodicAPIClientRequestCEDSearchCompletion)completion
{
    NSParameterAssert(completion);
    
    /**
     *  https://codic.jp/-/ced/search.json?query=QUERY
     */
    
    return [self requestWithResource:kCodicSearchURL
                          parameters:@{@"query" : query}
                          completion:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
                              completion(operation,
                                         error ? nil : [[CodicCEDSearchResult alloc] initWithDictionary:responseObject],
                                         error);
                          }];
}

- (AFHTTPRequestOperation *)requestWithResource:(NSString *)resource
                                     parameters:(NSDictionary *)parameters
                                     completion:(CodicAPIClientRequestCompletion)completion
{
    NSParameterAssert(completion);
    
    NSURL *url = [NSURL URLWithString:resource relativeToURL:[NSURL URLWithString:kCodicBaseURL]];
    
    return [self.client GET:url.absoluteString
                 parameters:parameters
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        completion(operation, responseObject, nil);
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        completion(operation, nil, error);
                    }];
}

@end
