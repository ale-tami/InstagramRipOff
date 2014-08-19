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

@end

@implementation FeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(FeedTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
