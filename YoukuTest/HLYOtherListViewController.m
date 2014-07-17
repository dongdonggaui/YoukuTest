//
//  HLYOtherListViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYOtherListViewController.h"
#import "HLYViewController.h"
#import "HLYVideoListBL.h"

@interface HLYOtherListViewController ()

@property (nonatomic, strong) NSArray *datas;

- (void)loadNewData;

@end

@implementation HLYOtherListViewController

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
    [self loadNewData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.datas) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.datas) {
        return self.datas.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = kCellIdentifierOtherList;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *dic = [self.datas objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.numberOfLines = 0;
    NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"thumbnail"]];
    [cell.imageView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"test_head"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:kSegueShowVideoPlayer sender:nil];
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueShowVideoPlayer]) {
        HLYViewController *vc = (HLYViewController *)[segue destinationViewController];
        vc.passValue = [self.datas objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}


- (void)loadNewData {
    
    [HLYVideoListBL getVideoListByUserId:@"UNDEwNDAyMzM2" onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        DLog(@"json = %@", json);
        self.datas = [json objectForKey:@"videos"];
        [self.tableView reloadData];

    } onFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error : %@", error.userInfo);
    }];
}

@end
