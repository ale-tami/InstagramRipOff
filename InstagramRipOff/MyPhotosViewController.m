//
//  MyPhotosViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "MyPhotosViewController.h"

@interface MyPhotosViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *myPhotosCollectionView;

@property (strong, nonatomic) NSMutableArray * photos;
@end

@implementation MyPhotosViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photos = [[NSMutableArray alloc]init];

}


-(void)viewDidAppear:(BOOL)animated{
    
    [self.photos removeAllObjects];
    
    PFUser *currentUser = [ PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"FeedItem"];
    [query whereKey:@"user" equalTo:currentUser.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            for (PFObject *object in objects) {
                
                PFFile *imageFile = [object objectForKey:@"feedPhoto"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:data];
                        [self.photos addObject: image];
                        [self.myPhotosCollectionView reloadData];
                        
                    }
                }];
                
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionView Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myPhotosFeedCell" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[self.photos objectAtIndex:indexPath.row]];
    
    return cell;
}



@end
