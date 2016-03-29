//
//  JDServerManager.h
//  VKClient
//
//  Created by jsd on 15.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>
#import "JDUser.h"

@interface JDServerManager : NSObject

+ (instancetype)sharedManager;

- (NSURLSessionDataTask*) getUserInfoForId: (NSString*) userId
                                 onSuccess: (void(^)(JDUser* user, BOOL cached)) success
                                   failure: (void(^)(NSError* error)) failure;

- (NSURLSessionDataTask*) getNewsFeedOnSuccess: (void(^)(NSArray* feeds)) success
                                     onFailure: (void(^)(NSError* error)) failure;

- (NSURLSessionDataTask*) getFriendsForUserId: (NSString*) userId
                                    onSuccess: (void(^)(NSArray* friends)) success
                                    onFailure: (void(^)(NSError* error)) failure;

@end
