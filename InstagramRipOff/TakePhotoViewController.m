//
//  TakePhotoViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "TakePhotoViewController.h"

@interface TakePhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property NSArray *user;
@property UIImagePickerController *picker;
@property (strong, nonatomic) IBOutlet UITextView *photoDescription;
@end

@implementation TakePhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.picker = [UIImagePickerController new];
    self.picker.delegate = self;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


}
- (IBAction)onUploadPhoto:(UIButton *)sender
{
    [self presentViewController:self.picker animated:YES completion:nil];
}

#pragma mark -- UIImagePickerController Delegates
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    PFObject *feedItem = [PFObject objectWithClassName:@"FeedItem"];
    // [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage]);
    PFFile *imageFile = [PFFile fileWithName:@"feedPhoto" data:imageData];
    feedItem[@"feedPhoto"] = imageFile;
    feedItem[@"user"] = [PFUser currentUser].objectId;
    feedItem[@"description"] = self.photoDescription.text;
    [feedItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@", [error userInfo]);
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
            self.photoDescription.text = @"";
        }
    }];

//    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
