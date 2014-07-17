//
//  HLYViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-16.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYViewController.h"

@interface HLYViewController ()

- (IBAction)btnTapped:(UIButton *)sender;
- (IBAction)regux:(id)sender;

@end

@implementation HLYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
