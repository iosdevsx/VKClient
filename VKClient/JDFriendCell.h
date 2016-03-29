//
//  JDFriendCell.h
//  VKClient
//
//  Created by jsd on 28.03.16.
//  Copyright © 2016 jsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end
