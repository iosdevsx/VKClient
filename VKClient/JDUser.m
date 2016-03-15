//
//  JDUser.m
//  VKClient
//
//  Created by jsd on 15.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDUser.h"
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
    NSLog(@"%@ %@ %@", user.id, user.first_name, user.last_name);
    NSDictionary* dictionary = @{@"currentUserId":user.id};
    BOOL oke = [dictionary writeToFile:path atomically:NO];
    if (oke)
    {
        NSLog(@"oke");
    }
    
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:[NSString pathForFileName:@"user.plist"]];
    JDUser* curr = [JDUser MR_findFirstByAttribute:@"id" withValue:dict[@"currentUserId"]];
    NSLog(@"%@ %@ %@", curr.id, curr.first_name, curr.last_name);

}

@end
