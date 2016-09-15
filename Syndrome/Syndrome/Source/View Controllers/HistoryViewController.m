//
//  HistoryViewController.m
//  Syndrome
//
//  Created by Djuro Alfirevic on 9/15/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "HistoryViewController.h"
#import "PatientViewController.h"
#import "DataManager.h"
#import "Patient+CoreDataClass.h"
#import "PatientTableViewCell.h"

@interface HistoryViewController()
@property (strong, nonatomic) NSArray *patientsArray;
@end

@implementation HistoryViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.patientsArray = [[DataManager sharedInstance]
                          fetchEntity:NSStringFromClass([Patient class])
                          withFilter:nil
                          withSortAsc:NO
                          forKey:nil];
    
    [self.tableView reloadData];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[PatientViewController class]]) {
        PatientViewController *toViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        toViewController.patient = self.patientsArray[indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.patientsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell"];
    
    cell.patient = self.patientsArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
