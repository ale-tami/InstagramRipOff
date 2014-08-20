//
//  LogInViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([PFUser currentUser] && [[PFUser currentUser] isAuthenticated]) {
        NSLog(@"Authenticated");
    }
}


@end
