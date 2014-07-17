//
//  HLYTVInfoViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYTVInfoViewController.h"
#import "HLYViewController.h"
#import "HLYVideoListBL.h"

@interface HLYTVInfoViewController ()

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation HLYTVInfoViewController

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray arrayWithCapacity:10];
    }
    
    return _datas;
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
    static NSString *CellIdentifier = kCellIdentifierTVInfo;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *dic = [self.datas objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"第 %@ 集", [dic objectForKey:@"order"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:kSegueShowVideoPlayer sender:nil];
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueShowVideoPlayer]) {
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        NSDictionary *dic = [self.datas objectAtIndex:indexPath.row];
        
        NSString *url = [dic objectForKey:@"url"];
        NSRegularExpression *regux = [NSRegularExpression regularExpressionWithPattern:@"id_[0-9a-zA-Z]+" options:0 error:nil];
        NSTextCheckingResult *result = [regux firstMatchInString:url options:0 range:NSMakeRange(0, url.length)];
        NSString *sub = [url substringWithRange:result.range];
        NSString *tvId = [sub substringFromIndex:3];
        DLog(@"sub = %@, tvid = %@", sub, tvId);
        
        HLYViewController *vc = (HLYViewController *)[segue destinationViewController];
        vc.passValue = tvId;
        
    }
}

- (void)loadNewData {
    
    [HLYVideoListBL getTVInfoByTVID:self.passValue onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        DLog(@"json = %@", json);
        [self.datas addObjectsFromArray:[[[json objectForKey:self.passValue] lastObject] objectForKey:@"addresses"]];
        DLog(@"datas = %@", [[[json objectForKey:self.passValue] lastObject] objectForKey:@"addresses"]);
        [self.tableView reloadData];
        
    } onFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error : %@", error.userInfo);
    }];
}

@end
