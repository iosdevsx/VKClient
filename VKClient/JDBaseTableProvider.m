//
//  JDBaseTableProvider.m
//  VKClient
//
//  Created by jsd on 29.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDBaseTableProvider.h"

@implementation JDBaseTableProvider


#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate cellSelectedAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate cellDeleteAtIndexPath:indexPath];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //переопределяется в дочернем классе
}

@end
