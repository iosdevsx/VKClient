//
//  NSString+Helper.m
//  VKClient
//
//  Created by jsd on 15.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

+ (NSString*) pathForFileName: (NSString*) name
{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths firstObject] stringByAppendingPathComponent:name];
}


@end
