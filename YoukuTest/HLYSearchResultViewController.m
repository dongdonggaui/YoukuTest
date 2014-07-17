//
//  HLYSearchResultViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYSearchResultViewController.h"
#import "HLYVideoListBL.h"
#import "HLYViewController.h"

@interface HLYSearchResultViewController ()

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, unsafe_unretained) int currentPage;
@property (nonatomic, strong) UIView * tableFooterView;

- (void)loadNewData;
- (void)loadMoreData;

@end

@implementation HLYSearchResultViewController

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray arrayWithCapacity:20];
    }
    
    return _datas;
}

- (UIView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
        UILabel *label = [[UILabel alloc] initWithFrame:_tableFooterView.frame];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%@...", NSLocalizedString(@"Loading", @"")];
        label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        [_tableFooterView addSubview:label];
    }
    
    return _tableFooterView;
}

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
    self.currentPage = 1;
    [self loadNewData];
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
    static NSString *CellIdentifier = kCellIdentifierSearchResult;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.datas) {
        self.tableView.tableFooterView = nil;
        return;
    }
    
    if (indexPath.row == self.datas.count - 1) {
        
        self.tableView.tableFooterView = self.tableFooterView;
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self loadMoreData];
        });
        
    }
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueShowVideoPlayer]) {
        HLYViewController *vc = (HLYViewController *)[segue destinationViewController];
        vc.passValue = [self.datas objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

- (void)loadNewData {
    [HLYVideoListBL getVideoListByKeyword:self.passValue onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        DLog(@"json = %@", json);
        [self.datas addObjectsFromArray:[json objectForKey:@"videos"]];
        [self.tableView reloadData];
        
    } onFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error : %@", error.userInfo);
    }];
}

- (void)loadMoreData {
    self.currentPage++;
    [HLYVideoListBL getVideoListByKeyword:self.passValue page:self.currentPage onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        DLog(@"json = %@", json);
        [self.datas addObjectsFromArray:[json objectForKey:@"videos"]];
        [self.tableView reloadData];
        
    } onFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error : %@", error.userInfo);
    }];
}

@end
