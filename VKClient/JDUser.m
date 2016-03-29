//
//  JDUser.m
//  VKClient
//
//  Created by jsd on 15.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDUser.h"
#import "JDFriend.h"
#import "NSString+Helper.h"

@implementation JDUser

+ (JDUser*) currentUser
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:[NSString pathForFileName:@"user.plist"]];
    if (!dictionary)
    {
        return nil;
    }
    return [JDUser MR_findFirstByAttribute:@"id" withValue:dictionary[@"currentUserId"]];
}

+ (void) setCurrentUser: (nullable JDUser*) user
{
    NSString* path = [NSString pathForFileName:@"user.plist"];
    if (!user)
    {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return;
    }
    NSDictionary* dictionary = @{@"currentUserId":user.id};
    [dictionary writeToFile:path atomically:NO];
}

+ (NSArray*) sortedFriends
{
    NSArray* friends = [[JDUser currentUser].friends allObjects];
    NSSortDescriptor* firstDesc = [[NSSortDescriptor alloc] initWithKey:@"first_name" ascending:YES];
    NSSortDescriptor* lastDesc = [[NSSortDescriptor alloc] initWithKey:@"last_name" ascending:YES];
    return [friends sortedArrayUsingDescriptors:@[firstDesc, lastDesc]];
}

+ (void) removeCurrentUser
{
    [JDFriend removeAll];
    [[JDUser currentUser] MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
    [JDUser setCurrentUser:nil];
}


@end
