//
//  JDFriend.h
//  VKClient
//
//  Created by jsd on 28.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class JDUser;

NS_ASSUME_NONNULL_BEGIN

@interface JDFriend : NSManagedObject

+ (void) removeAll;

@end

NS_ASSUME_NONNULL_END

#import "JDFriend+CoreDataProperties.h"
