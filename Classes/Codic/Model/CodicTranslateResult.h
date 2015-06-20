//
//  CodicTranslateResult.h
//  Codic
//
//  Created by Yu Sugawara on 6/21/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CodicModel.h"
@class CodicTranslation;

@interface CodicTranslateResult : CodicModel

- (CodicTranslation *)translation;

@end

@interface CodicTranslation : CodicModel

- (BOOL)successful;                     // e.g. 1
- (NSInteger)id;                        // e.g. 206022
- (NSString *)text;                     // e.g. \U53d6\U5f97
- (NSString *)translatedText;           // e.g. fetch
- (NSString *)translatedWithCasing;     // e.g. fetch
- (NSArray *)phrases;

@end