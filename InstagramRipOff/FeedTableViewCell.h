//
//  FeedTableViewCell.h
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userProfImage;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timePostedLabel;
@property (strong, nonatomic) IBOutlet UIImageView *feedImage;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedTagsLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedCommentsLabel;

@end
