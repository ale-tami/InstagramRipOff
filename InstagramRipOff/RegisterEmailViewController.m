//
//  RegisterEmailViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "RegisterEmailViewController.h"

@interface RegisterEmailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UITextField *userEmailField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *userPasswordField;

@end

@implementation RegisterEmailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)onAddPhotoTapped:(UIButton *)sender
{

}

- (IBAction)onExitTextField:(UITextField *)sender
{
    [sender resignFirstResponder];
}

@end
