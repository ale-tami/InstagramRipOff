//
//  ViewController.m
//  InstagramRipOff
//
//  Created by Alejandro Tami on 19/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property UIActivityIndicatorView *spinner;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onRegisterWithFacebookTapped:(id)sender
{
    NSArray *permissionsArray = @[ @"user_about_me"];
    [PFFacebookUtils initializeFacebook];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
//        } else if (user.isNew) {
//            NSLog(@"User with facebook signed up and logged in!");
        } else {
            
            // Create request for user's Facebook data
            [self showSpinner];
            [self requestForFbUser: user];
            NSLog(@"User with facebook logged in!");
        }
        
    }];

}

- (void) requestForFbUser: (PFUser *) user
{
     FBRequest *request = [FBRequest requestForMe];
    
    __block PFUser *userAux = user;
    
     [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            
            NSURL *pictureURL = [NSURL URLWithString:
                                [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            

                NSURLRequest *request = [NSURLRequest requestWithURL:pictureURL];
                
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    PFFile *imageFile = [PFFile fileWithName:@"profile.png" data:data];
                    [userAux setObject: imageFile forKey:@"profilePicture"];
                    [userAux setObject: name forKey:@"username"];
                    
                    NSError *error = nil;
                    [userAux save:&error];
                    
                    NSLog(@"%@", [error description]);
                    
                    [self performSegueWithIdentifier:@"rootToLoginSeg" sender:self];
                    
                    [self.spinner removeFromSuperview];
                    
                 }];
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


@end
