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
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([PFUser currentUser] && [[PFUser currentUser] isAuthenticated]) {
        NSLog(@"Authenticated");
        [self performSegueWithIdentifier:@"segueToFeed" sender:self];
    }

}

- (IBAction)onDidExitTextField:(UITextField *)sender
{
    
}

- (IBAction)onLoggedInTapped:(UIButton *)sender
{
    PFUser * user = [PFUser logInWithUsername:self.usernameField.text password:self.passwordField.text];
    if (!user) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nope"
                                                        message:@"Wrong user/password"
                                                       delegate:self
                                              cancelButtonTitle:@"Bummer... ok"
                                              otherButtonTitles:nil];
        [alert show];

    } else {
        [self performSegueWithIdentifier:@"segueToFeed" sender:self];
    }
}

@end
