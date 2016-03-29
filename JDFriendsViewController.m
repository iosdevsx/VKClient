//
//  JDFriendsViewController.m
//  VKClient
//
//  Created by jsd on 28.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDFriendsViewController.h"
#import "JDFriendCell.h"
#import "JDServerManager.h"
#import "JDAccessToken.h"
#import "JDFriendsTableProvider.h"

@interface JDFriendsViewController() <JDBaseTableDelegate>

@property (strong, nonatomic) NSArray* friends;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
@property (strong, nonatomic) JDFriendsTableProvider* provider;
@property (strong, nonatomic) JDServerManager* serverManager;
@property (strong, nonatomic) UISearchController* searchController;

@end

@implementation JDFriendsViewController
@synthesize refreshControl = _refreshControl;

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.provider = [[JDFriendsTableProvider alloc] init];
    self.serverManager = [JDServerManager sharedManager];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.searchResultsUpdater = self.provider;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.provider.delegate = self;
    self.provider.searchController = self.searchController;
    self.tableView.delegate = self.provider;
    self.tableView.dataSource = self.provider;
    
    [self.refreshControl addTarget:self action:@selector(refreshItems) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self getFriendsFromServer];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PrivateMethods

- (void) getFriendsFromServer
{
    JDAccessToken* token = [JDAccessToken currentToken];
    if (token)
    {
        [self.serverManager getFriendsForUserId:token.userId onSuccess:^(NSArray *friends) {
            self.provider.items = [NSArray arrayWithArray:friends];
            [self.tableView reloadData];
            if ([self.refreshControl isRefreshing])
            {
                [self.refreshControl endRefreshing];
            }
        } onFailure:^(NSError *error) {
            NSLog(@"%@", [error localizedDescription]);
        }];
    }
}

- (void) refreshItems
{
    [JDFriend removeAll];
    [self getFriendsFromServer];
}

#pragma mark - JDBaseTableProvider

- (void) cellSelectedAtIndexPath: (nullable NSIndexPath*) indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) searchComplete
{
    [self.tableView reloadData];
}


@end
