//
//  HLYMainViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYMainViewController.h"

@interface HLYMainViewController ()

- (IBAction)btnTapped:(UIButton *)sender;
- (IBAction)regux:(id)sender;
- (IBAction)userList:(id)sender;
- (IBAction)search:(id)sender;
- (IBAction)searchTV:(id)sender;

@end

@implementation HLYMainViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.passValue isEqualToString:@"Auth Success"]) {
        [MBHUDView hudWithBody:self.passValue type:MBAlertViewHUDTypeCheckmark hidesAfter:1.5 show:YES];
    } else if ([self.passValue isEqualToString:@"Auth Failed"]) {
        [MBHUDView hudWithBody:self.passValue type:MBAlertViewHUDTypeExclamationMark hidesAfter:1.5 show:YES];
    }
}


- (IBAction)btnTapped:(UIButton *)sender {
    [self performSegueWithIdentifier:kSegueShowAuthView sender:nil];
}

- (IBAction)regux:(id)sender {
    //    NSString *testString = @"1234fscode=asdf98a89f7ad98sf===";
    //    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"code=[0-9A-Za-z]+" options:NSRegularExpressionCaseInsensitive error:nil];
    //    NSTextCheckingResult *result = [regx firstMatchInString:testString options:0 range:NSMakeRange(0, testString.length)];
    //    NSRange foundRange = result.range;
    //    DLog(@"loc = %d, length = %d", foundRange.location, foundRange.length);
    [self performSegueWithIdentifier:kSegueShowMyVideoList sender:nil];
}

- (IBAction)userList:(id)sender {
    [self performSegueWithIdentifier:kSegueShowUsersVideoList sender:nil];
}

- (IBAction)search:(id)sender {
    [self performSegueWithIdentifier:kSegueShowSearch sender:nil];
}

- (IBAction)searchTV:(id)sender {
    [self performSegueWithIdentifier:kSegueShowTVSearch sender:nil];
}

@end
