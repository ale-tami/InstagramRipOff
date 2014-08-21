//
//  ExploreCollectionViewCell.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/20/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ExploreCollectionViewCell.h"

@implementation ExploreCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onFollowUserTapped:(UIButton *)sender
{
    //use constants for keys
    PFObject *object = [PFObject objectWithClassName:@"FollowingUser"];
    
    [object setObject:[PFUser currentUser]  forKey:@"follower"];
    [object setObject:self.user.objectId  forKey:@"followed"];
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        sender.titleLabel.text = @"Following";
    }];
}


@end
