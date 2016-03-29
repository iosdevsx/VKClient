//
//  JDUser+CoreDataProperties.h
//  VKClient
//
//  Created by jsd on 29.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JDUser.h"
#import "JDFriend.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSSet<JDFriend *> *friends;

@end

@interface JDUser (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(JDFriend *)value;
- (void)removeFriendsObject:(JDFriend *)value;
- (void)addFriends:(NSSet<JDFriend *> *)values;
- (void)removeFriends:(NSSet<JDFriend *> *)values;

@end

NS_ASSUME_NONNULL_END
