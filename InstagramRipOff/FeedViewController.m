//
//  FeedViewController.m
//  InstagramRipOff
//
//  Created by ETC ComputerLand on 8/19/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedTableViewCell.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *feedItems;
@property (strong, nonatomic) IBOutlet UITableView *feedTable;
@end

@implementation FeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getFeedItems];

}

#pragma mark -- Table View Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feedItems.count;
}

-(FeedTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedTableCell"];
    PFObject *feedItem = self.feedItems[indexPath.row];
    cell.feedDescriptionLabel.text = feedItem[@"description"];
    PFFile *feedImage = feedItem[@"feedPhoto"];
    cell.feedImage.image = [UIImage imageNamed:@"placeholder.png"];
    [feedImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error) {
            cell.feedImage.image = [UIImage imageWithData:data];
        }
    }];
  //  PFUser *user = feedItem[@"user"];
    return cell;
}


- (void)getFeedItems
{
    //NSError *error = nil;

    // Get all feed items for now

//    PFQuery *query = [PFQuery queryWithClassName:@"FollowingUser"];
//    [query whereKey:@"follower" equalTo:[PFUser currentUser] ];
//
//    PFQuery *query2 = [PFUser query];
//
//    [query2 whereKey:@"objectId" matchesKey:@"followed" inQuery:query];
//
//    PFQuery *query3 = [PFQuery queryWithClassName:@"FeedItem"];
//    [query3 whereKey:@"user" matchesKey:@"followed" inQuery:query2];

    PFQuery *query = [PFQuery queryWithClassName:@"FollowingUser"];
    [query whereKey:@"follower" equalTo:[PFUser currentUser]];

    PFQuery *query2 = [PFUser query];
    [query2 whereKey:@"objectId" matchesKey:@"followed" inQuery:query];

    NSLog(@"%d",[query2 findObjects].count);
    
    PFQuery *query3 = [PFQuery queryWithClassName:@"FeedItem"];
    [query3 whereKey:@"user" matchesKey:@"objectId" inQuery:query2];
    
    NSLog(@"%@",[PFUser currentUser].username);


    [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"%@", [error userInfo]);
        } else {
            NSLog(@"%@", objects);
            self.feedItems = objects;
            [self.feedTable reloadData];
        }
    }];

    //    PFQuery *query = [PFQuery queryWithClassName:@"FeedItem"];

//    PFQuery *query = [PFQuery queryWithClassName:@"FollowingUser"];
//    [query whereKey:@"follower" equalTo:[PFUser currentUser] ];
//
//    PFQuery *query2 = [PFQuery queryWithClassName:@"FeedItem"];
//    [query2 whereKey:@"user" equalTo:query.following];
//    [query2 whereKey:@"objectId" doesNotMatchKey:@"followed" inQuery:query];


//    self.users = [query2 findObjects:&error];
//
//    NSLog(@"%@", error);
//
//    [self.exploreCollectionView reloadData];
}

@end
