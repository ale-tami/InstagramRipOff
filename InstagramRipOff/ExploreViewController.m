//
//  ExploreViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ExploreViewController.h"
#import "ExploreCollectionViewCell.h"

@interface ExploreViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *exploreCollectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchExplore;

@property NSArray *results;
@property int searchMode;

@end

@implementation ExploreViewController


-(void)viewDidAppear:(BOOL)animated{
    
    self.searchMode = 0;
    
    self.searchExplore.text = @"";
    
    [self performSelectorInBackground:@selector(makeSearch) withObject:nil];
    
    [self.exploreCollectionView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.results = [[NSArray alloc]init];
    
    self.searchExplore.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.view endEditing:YES];
    
    if ([self.searchExplore.text hasPrefix:@"#"]){
        self.searchMode = 1;
        [self searchTag];
    } else {
        [self searchUsername];
        self.searchMode = 0;
    }
}


#pragma mark - Helper Methods


-(void)searchTag{
    
    NSError *error = nil;
    NSArray * array = [NSArray arrayWithObject:self.searchExplore.text];
    PFQuery *query = [PFQuery queryWithClassName:@"FeedItem"];
    [query whereKey:@"description" containedIn:array];
    self.results = [query findObjects:&error];
    
    NSLog(@"found photos: %lu",(unsigned long)self.results.count);
    NSLog(@"%@", error);
    
    [self.exploreCollectionView reloadData];
    
}

-(void)searchUsername {
    
    NSError *error = nil;
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:self.searchExplore.text];
    self.results = [query findObjects:&error];
    
    NSLog(@"%@", error);
    
    [self.exploreCollectionView reloadData];
    
}


- (void)makeSearch
{
    NSError *error = nil;
    
    PFQuery *query = [PFQuery queryWithClassName:@"FollowingUser"];
    [query whereKey:@"follower" equalTo:[PFUser currentUser] ];
    
    PFQuery *query2 = [PFUser query];
    [query2 whereKey:@"objectId" notEqualTo:[PFUser currentUser].objectId];
    [query2 whereKey:@"objectId" doesNotMatchKey:@"followed" inQuery:query];
    
    self.results = [query2 findObjects:&error];
    
    NSLog(@"%@", error);
    
    [self.exploreCollectionView reloadData];
}



- (void) loadImageAsynchForCell: (ExploreCollectionViewCell*) cell
{
    PFFile *file;
    
    if (self.searchMode == 0){
    file = [cell.user objectForKey:@"profilePicture"];
    }else{
    file = [cell.photo objectForKey:@"feedPhoto"];
    }
    
    if (file) {
        cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[file getData]]] ;
    } else {
        cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"placeholder.png"]] ;
    }

}


#pragma mark - Collection View Delegate


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.results.count;
        
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExploreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"exploreCell" forIndexPath:indexPath];
    
    if (self.searchMode == 0){

        PFUser *user = [self.results objectAtIndex:indexPath.row];
        cell.user = user;
    } else {
        PFObject *photo = [self.results objectAtIndex:indexPath.row];
        cell.photo = photo;
    }
    
    [self performSelectorInBackground:@selector(loadImageAsynchForCell:) withObject:cell];
     return cell;
}


@end
