//
//  JDUser.h
//  VKClient
//
//  Created by jsd on 15.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import "JDParentUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDUser : JDParentUser

+ (JDUser*) currentUser;
+ (void) setCurrentUser: (nullable JDUser*) user;
+ (NSArray*) sortedFriends;
+ (void) removeCurrentUser;

@end

NS_ASSUME_NONNULL_END

#import "JDUser+CoreDataProperties.h"
