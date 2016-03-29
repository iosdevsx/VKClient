//
//  JDServerManager.m
//  VKClient
//
//  Created by jsd on 15.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDServerManager.h"
#import "JDAccessToken.h"
#import "JDUser.h"
#import "JDFriend.h"

@interface JDServerManager()

@property (strong, nonatomic) AFHTTPSessionManager* session;

@end

@implementation JDServerManager

+ (instancetype)sharedManager
{
    static JDServerManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JDServerManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSString* apiString = @"https://api.vk.com/method/";
        NSURL* apiUrl = [NSURL URLWithString:apiString];
        self.session = [[AFHTTPSessionManager alloc] initWithBaseURL:apiUrl];
    }
    return self;
}


#pragma mark - Users
- (NSURLSessionDataTask*) getUserInfoForId: (NSString*) userId
                onSuccess: (void(^)(JDUser* user, BOOL cached)) success
                  failure: (void(^)(NSError* error)) failure
{
    JDUser* cachedUser = [JDUser MR_findFirstByAttribute:@"id" withValue:userId];
    if (cachedUser)
    {
        success(cachedUser, YES);
    }
    NSURLSessionDataTask* task = [self.session
                                  GET:@"users.get"
                                  parameters:@{@"user_ids":userId,
                                               @"name_case":@"Nom",
                                               @"fields":@"photo_50",
                                               @"v":@5.50}
                                          progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSDictionary* response = ((NSArray*)responseObject[@"response"]).lastObject;
                                      JDUser* user = [JDUser MR_importFromObject:response];
                                      [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
                                      if (!cachedUser)
                                      {
                                          success(user, NO);
                                      }
                                  }
                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      if (failure)
                                      {
                                          NSLog(@"error is %@", [error localizedDescription]);
                                          failure(error);
                                      }
                                  }];
    return task;
}

- (NSURLSessionDataTask*) getFriendsForUserId: (NSString*) userId
                                    onSuccess: (void(^)(NSArray* friends)) success
                                    onFailure: (void(^)(NSError* error)) failure

{
    NSArray* friendsInCache = [JDUser sortedFriends];
    if ([friendsInCache count] > 0)
    {
        success(friendsInCache);
        return nil;
    }
    
    NSURLSessionDataTask* task = [self.session GET:@"friends.get"
                                        parameters:@{@"user_id":userId,
                                                     @"order":@"name",
                                                     @"fields":@"photo_50",
                                                     @"name_case":@"nom",
                                                     @"lang":@"ru"}
                                          progress:nil
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                  {
                                      NSArray* friends = [JDFriend MR_importFromArray:responseObject[@"response"]];
                                      NSSet* friendsSet = [NSSet setWithArray:friends];
                                      [[JDUser currentUser] setFriends:friendsSet];
                                      
                                      [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
                                      success(friends);
                                  }
                                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                  {
                                      NSLog(@"%@", [error localizedDescription]);
                                  }];
    return task;
}

#pragma mark - News

- (NSURLSessionDataTask*) getNewsFeedOnSuccess: (void(^)(NSArray* feeds)) success
                                     onFailure: (void(^)(NSError* error)) failure
{
    JDAccessToken* currentToken = [JDAccessToken currentToken];
    
    NSURLSessionDataTask* task = [self.session
                                  GET:@"newsfeed.get"
                                  parameters:@{@"filters":@"post",
                                               @"access_token":currentToken.token}
                                  progress:nil
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      NSMutableArray* array = [NSMutableArray array];
                                      NSDictionary* response = [responseObject objectForKey:@"response"];
                                      NSArray* items = [response objectForKey:@"items"];
                                      for (NSDictionary* fields in items)
                                      {
                                          NSString* text = [fields objectForKey:@"text"];
                                          [array addObject:text];
                                      }
                                      success([NSArray arrayWithArray:array]);
                                  }
                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      
                                  }];
    return task;
}

@end
