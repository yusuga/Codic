//
//  TranslateViewController.m
//  Codic
//
//  Created by Yu Sugawara on 6/21/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "TranslateViewController.h"
#import "CodicAPIClient.h"

@interface TranslateViewController ()

@property (weak, nonatomic) AFHTTPRequestOperation *operation;
@property (nonatomic) CodicTranslateResult *result;

@end

@implementation TranslateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.result ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CodicTranslation *translation = self.result.translation;
    
    cell.textLabel.text = translation.translatedText;
    [cell.textLabel sizeToFit];    
    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length) {
        [self.operation cancel];
        
        __weak typeof(self) wself = self;
        self.operation = [[CodicAPIClient sharedClient] requestTranslateWithQuery:textField.text
                                                                       completion:^(AFHTTPRequestOperation *operation, CodicTranslateResult *result, NSError *error)
                          {
                              wself.result = result;
                              [wself.tableView reloadData];
                          }];
    }
    return YES;
}

@end
