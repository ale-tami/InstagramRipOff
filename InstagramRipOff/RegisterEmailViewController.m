//
//  RegisterEmailViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "RegisterEmailViewController.h"

@interface RegisterEmailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
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
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];

}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.userImage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)onExitTextField:(UITextField *)sender
{
    [sender resignFirstResponder];
 
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.userPasswordField.text;
    user.email = self.userEmailField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Sign Up Succesfully!");
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Error: %@",errorString);
        }
    }];
    
    
}

@end
