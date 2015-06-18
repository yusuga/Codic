//
//  CEDSearchViewController.m
//  Codic
//
//  Created by Yu Sugawara on 6/19/15.
//  Copyright (c) 2015 Yu Sugawara. All rights reserved.
//

#import "CEDSearchViewController.h"
#import "CodicAPIClient.h"

@interface CEDSearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) AFHTTPRequestOperation *operation;
@property (nonatomic) CodicCEDSearchResult *result;

@end

@implementation CEDSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.result.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CodicCED *ced = self.result.data[indexPath.row];
    
    cell.textLabel.text = ced.title;
    [cell.textLabel sizeToFit];
    
    cell.detailTextLabel.text = ced.digest;
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
        self.operation = [[CodicAPIClient sharedClient] requestCEDSearchWithQuery:textField.text
                                                                       completion:^(AFHTTPRequestOperation *operation, CodicCEDSearchResult *result, NSError *error)
                          {
                              wself.result = result;
                              [wself.tableView reloadData];
                          }];
    }
    return YES;
}

@end
