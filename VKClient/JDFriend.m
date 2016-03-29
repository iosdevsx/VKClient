//
//  JDFriend.m
//  VKClient
//
//  Created by jsd on 28.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "JDFriend.h"
#import "JDUser.h"

@implementation JDFriend

+ (void) removeAll
{
    [JDFriend MR_truncateAll];
}

@end
