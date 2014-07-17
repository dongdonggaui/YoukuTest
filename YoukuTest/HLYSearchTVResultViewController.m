//
//  HLYSearchTVResultViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYSearchTVResultViewController.h"
#import "HLYVideoListBL.h"
#import "HLYViewController.h"

@interface HLYSearchTVResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

- (void)configureCellWithProperties:(NSDictionary *)properties;

@end

@implementation HLYSearchTVResultCell

- (void)configureCellWithProperties:(NSDictionary *)properties {
    NSURL *url = [NSURL URLWithString:[properties objectForKey:@"thumbnail"]];
    [self.thumbnailImageView setImageWithURL:url placeholderImage:[[UIImage imageNamed:@"test_head"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)]];
    self.titleLabel.text = [properties objectForKey:@"name"];
    self.descLabel.text = [properties objectForKey:@"description"];
}

@end

@interface HLYSearchTVResultViewController ()

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, unsafe_unretained) int currentPage;
@property (nonatomic, strong) UIView * tableFooterView;

- (void)loadNewData;
- (void)loadMoreData;

@end

@implementation HLYSearchTVResultViewController

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
        return self.datas.count == 0 ? 1 : self.datas.count;
    }
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.datas.count == 0) {
        return 40;
    }
    
    return 221;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLYSearchTVResultCell *cell;
    
    // Configure the cell...
    if (self.datas.count == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierTVSearchResultNull forIndexPath:indexPath];
        cell.textLabel.text = NSLocalizedString(@"No search result", nil);
        cell.userInteractionEnabled = NO;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierTVSearchResult forIndexPath:indexPath];
        NSDictionary *dic = [self.datas objectAtIndex:indexPath.row];
        [cell configureCellWithProperties:dic];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:kSegueShowTVInfo sender:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.datas) {
        self.tableView.tableFooterView = nil;
        return;
    }
    
//    if (indexPath.row == self.datas.count - 1) {
//        
//        self.tableView.tableFooterView = self.tableFooterView;
//        
//        double delayInSeconds = 2.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self loadMoreData];
//        });
//        
//    }
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueShowTVInfo]) {
        HLYViewController *vc = (HLYViewController *)[segue destinationViewController];
        vc.passValue = [[self.datas objectAtIndex:self.tableView.indexPathForSelectedRow.row] objectForKey:@"id"];
    }
}

- (void)loadNewData {
    [HLYVideoListBL getTVListByKeyword:self.passValue page:self.currentPage onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        DLog(@"json = %@", json);
        [self.datas addObjectsFromArray:[json objectForKey:@"shows"]];
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
