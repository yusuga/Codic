//
//  SearchViewController.m
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "SearchViewController.h"
#import "CodicAPIClient.h"

@interface SearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) AFHTTPRequestOperation *operation;
@property (nonatomic) CodicSearchResult *result;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.result.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CodicSearch *search = self.result.data[indexPath.row];
    
    cell.textLabel.text = search.title;
    [cell.textLabel sizeToFit];
    
    cell.detailTextLabel.text = search.digest;
    [cell.detailTextLabel sizeToFit];
    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length) {
        [self.operation cancel];
        
        __weak typeof(self) wself = self;
        self.operation = [[CodicAPIClient sharedClient] requestSearchWithQuery:textField.text
                                                                    completion:^(AFHTTPRequestOperation *operation, CodicSearchResult *result, NSError *error)
                          {
                              wself.result = result;
                              [wself.tableView reloadData];
                          }];
    }
    return YES;
}

@end
