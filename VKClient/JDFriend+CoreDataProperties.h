//
//  JDFriend+CoreDataProperties.h
//  VKClient
//
//  Created by jsd on 29.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JDFriend.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDFriend (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *uid;
@property (nullable, nonatomic, retain) JDUser *currentUser;

@end

NS_ASSUME_NONNULL_END
