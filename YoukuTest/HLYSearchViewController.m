//
//  HLYSearchViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYSearchViewController.h"
#import "HLYViewController.h"

@interface HLYSearchViewController () <UISearchDisplayDelegate, UISearchBarDelegate>

@end

@implementation HLYSearchViewController

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
    [self performSegueWithIdentifier:kSegueShowSearchResult sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueShowSearchResult]) {
        HLYViewController *vc = (HLYViewController *)[segue destinationViewController];
        vc.passValue = self.searchDisplayController.searchBar.text;
    }
}

@end
