//
//  RegisterEmailViewController.m
//  InstagramRipOff
//
//  Created by Nicolas Semenas on 8/19/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "RegisterEmailViewController.h"

@interface RegisterEmailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UITextField *userEmailField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *userPasswordField;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

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

- (IBAction)onRegister:(id)sender {
    [sender resignFirstResponder];
    
    if ([self checkFields]){
        [self saveUserToParse];
    };
}




#pragma mark - Helper Methods


-(void) saveUserToParse {
    
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.userPasswordField.text;
    user.email = self.userEmailField.text;
    
    NSData *imageData = UIImagePNGRepresentation(self.userImage.image);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    [user setObject:imageFile forKey:@"profilePicture"];
    
    [self showSpinner];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.spinner removeFromSuperview];
            NSString *successMsg = [NSString stringWithFormat:@"Welcome user %@ !. Now try login with your username and password",self.usernameField.text];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                            message:successMsg
                                                           delegate:self
                                                  cancelButtonTitle:@"Cool!"
                                                  otherButtonTitles:nil];
            [alert show];
            
        } else {
            [self.spinner removeFromSuperview];
            NSString *errorString = [error userInfo][@"error"];
            NSString *errorMsg = [NSString stringWithFormat:@"%@",errorString];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went wrong!"
                                                            message:errorMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}


-(void) showSpinner{
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(160, 240);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
}



-(BOOL) checkFields {
    
    if ([self.userEmailField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went wrong!"
                                                        message:@"Please enter a valid email address"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
    if ([self.usernameField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went wrong!"
                                                        message:@"Please enter a valid username"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
    
    if ([self.userPasswordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something went wrong!"
                                                        message:@"Please enter a valid password"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
    return YES;
    
}



#pragma mark - UIImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.userImage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

