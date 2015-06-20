//
//  CodicAPIClient.m
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CodicAPIClient.h"

static NSString * const kCodicBaseURLString = @"https://codic.jp";

static NSString * const kCodicSearchURLString = @"/-/ced/search.json";
static NSString * const kCodicTranslateURLString = @"/-/engine/translate.json";

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
        
        [self.client.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        
        AFJSONResponseSerializer *serializer =[AFJSONResponseSerializer serializer];
        serializer.removesKeysWithNullValues = YES;
        self.client.responseSerializer = serializer;
    }
    return self;
}

- (AFHTTPRequestOperation *)requestSearchWithQuery:(NSString *)query
                                        completion:(CodicAPIClientRequestSearchCompletion)completion
{
    NSParameterAssert(completion);
    
    /**
     *  https://codic.jp/-/ced/search.json?query=QUERY
     */
    
    return [self.client GET:[self codicURLStringWithResource:kCodicSearchURLString]
                 parameters:@{@"query" : query}
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        completion(operation, [[CodicSearchResult alloc] initWithDictionary:responseObject], nil);
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        completion(operation, nil, error);
                    }];
}

- (AFHTTPRequestOperation *)requestTranslateWithQuery:(NSString *)query
                                           completion:(CodicAPIClientRequestTranslateCompletion)completion
{
    /**
     *  https://codic.jp/-/engine/translate.json
     */
    
    return [self.client POST:[self codicURLStringWithResource:kCodicTranslateURLString]
                  parameters:@{@"acronym_style" : @"literal",
                               @"casing" : @"lower underscore",
                               @"dictionary_id" : @"0",
                               @"data[0][id]" : @"0", // dummy
                               @"data[0][text]" : query}
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         completion(operation, [[CodicTranslateResult alloc] initWithDictionary:responseObject], nil);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         completion(operation, nil, error);
                     }];
}

#pragma mark - Private

- (NSString *)codicURLStringWithResource:(NSString *)resource
{
    return [NSURL URLWithString:resource relativeToURL:[NSURL URLWithString:kCodicBaseURLString]].absoluteString;
}

@end
