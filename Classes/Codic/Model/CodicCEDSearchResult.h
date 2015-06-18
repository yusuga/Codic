//
//  CodicCEDSearchResult.h
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CodicModel.h"

@interface CodicCEDSearchResult : CodicModel

- (NSString *)status;           // e.g. success
- (NSArray *)data;              // NSArray of CodicCED

@end

@interface CodicCED : CodicModel

- (NSInteger)id;                // e.g. 43432
- (NSString *)title;            // e.g. request
- (NSString *)digest;           // e.g. 頼む、要求、依頼
- (BOOL)published;              // e.g. true
- (BOOL)isRedirect;             // e.g. false
- (NSString *)redirectTo;       // e.g. null

@end
