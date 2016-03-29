//
//  JDParentUser+CoreDataProperties.h
//  VKClient
//
//  Created by jsd on 29.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JDParentUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDParentUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *first_name;
@property (nullable, nonatomic, retain) NSString *last_name;
@property (nullable, nonatomic, retain) NSString *photo_50;

@end

NS_ASSUME_NONNULL_END
