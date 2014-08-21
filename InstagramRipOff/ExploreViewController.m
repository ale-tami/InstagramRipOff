//
//  ExploreViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ExploreViewController.h"
#import "ExploreCollectionViewCell.h"

@interface ExploreViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *exploreCollectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchExplore;

@property NSArray *users;

@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelectorInBackground:@selector(makeSearch) withObject:nil];
    
}

- (void)makeSearch
{
    NSError *error = nil;
    
    PFQuery *query = [PFQuery queryWithClassName:@"FollowingUser"];
    [query whereKey:@"follower" equalTo:[PFUser currentUser] ];
    
    PFQuery *query2 = [PFUser query];
    [query2 whereKey:@"objectId" notEqualTo:[PFUser currentUser].objectId];
    [query2 whereKey:@"objectId" doesNotMatchKey:@"followed" inQuery:query];
    
//    PFQuery *query3 = [PFQuery queryWithClassName:@"FeedItem"];
//    [query3 whereKey:@"user" matchesKey:@"followed" inQuery:query2];
    
    self.users = [query2 findObjects:&error];
    
    NSLog(@"%@", error);
    
    [self.exploreCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadImageAsynchForCell: (ExploreCollectionViewCell*) cell
{
    
    PFFile *file = [cell.user objectForKey:@"profilePicture"];
    
    if (file) {
        cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[file getData]]] ;
    } else {
        cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"placeholder.png"]] ;
    }

}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"exploreCell" forIndexPath:indexPath];
    
    PFUser *user = [self.users objectAtIndex:indexPath.row];
    
    cell.user = user;
    
    [self performSelectorInBackground:@selector(loadImageAsynchForCell:) withObject:cell];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
