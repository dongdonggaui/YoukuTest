//
//  HLYSearchTVViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYSearchTVViewController.h"
#import "HLYViewController.h"

@interface HLYSearchTVViewController () <UISearchBarDelegate, UISearchDisplayDelegate>

@end

@implementation HLYSearchTVViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    DLog(@"123123123");
    [self performSegueWithIdentifier:kSegueShowTVSearchResult sender:nil];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    DLog(@"will show");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueShowTVSearchResult]) {
        HLYViewController *vc = (HLYViewController *)[segue destinationViewController];
        vc.passValue = self.searchDisplayController.searchBar.text;
    }
}

@end
