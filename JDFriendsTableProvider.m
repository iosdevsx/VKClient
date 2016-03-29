//
//  JDFriendsTableProvider.m
//  VKClient
//
//  Created by jsd on 29.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDFriendsTableProvider.h"
#import "JDFriend.h"
#import "JDFriendCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString* cellId = @"JDFriendCell";

@implementation JDFriendsTableProvider

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active)
    {
        return [self.filteredItems count];
    } else
    {
        return [self.items count];
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDFriendCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    JDFriend* friend;
    if (self.searchController.active)
    {
        friend = [self.filteredItems objectAtIndex:indexPath.row];
    } else
    {
        friend = [self.items objectAtIndex:indexPath.row];
    }
    
    cell.firstName.text = friend.first_name;
    cell.lastName.text = friend.last_name;
    [cell.photo sd_setImageWithURL:[NSURL URLWithString:friend.photo_50]];
    cell.photo.layer.cornerRadius = 25.f;
    cell.photo.layer.masksToBounds = YES;
    
    return cell;
}

#pragma mark - UISearchResultsUpdating

//Обновляем таблицу учитывая критерии поиска
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.filteredItems = nil;
    if (searchController.searchBar.text.length == 0)
    {
        self.filteredItems = self.items;
    } else
    {
        NSPredicate* searchPredicate = [NSPredicate predicateWithFormat:@"first_name BEGINSWITH[cd] %@", searchController.searchBar.text];
        self.filteredItems = [self.items filteredArrayUsingPredicate:searchPredicate];
    }
    [self.delegate searchComplete];
}


@end
