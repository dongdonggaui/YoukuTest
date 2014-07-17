//
//  HLYAuthViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-16.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYAuthViewController.h"
#import "HLYViewController.h"

@interface HLYAuthViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)startAuth;

@end

@implementation HLYAuthViewController

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
    [self startAuth];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAuth {
    NSString *path = [NSString stringWithFormat:@"https://openapi.youku.com/v2/oauth2/authorize?%@=%@&%@=%@&%@=%@", @"client_id", kYoukuAppKey, @"response_type", @"code", @"redirect_uri", kYoukuRedirectUri];
    NSURL *url = [NSURL URLWithString:path];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];
}

- (void)test {
    NSURL *url = [NSURL URLWithString:@"https://openapi.youku.com"];
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    NSString *path = @"/v2/oauth2/authorize";
    NSDictionary *dic = @{@"client_id": kYoukuAppKey,
                          @"response_type": @"code",
                          @"redirect_uri": kYoukuRedirectUri};
    
    [client getPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //
        //        [self.webView loadHTMLString:response baseURL:nil];
        [self.webView loadData:responseObject MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"error : %@", error);
    }];
}

#pragma mark - web view delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    DLog(@"did start with url ===> %@", webView.request.URL);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSRange range = NSMakeRange(0, kYoukuRedirectUri.length);
    __weak NSString *urlString = request.URL.absoluteString;
    if (urlString.length > range.length) {
        if ([[urlString substringWithRange:range] isEqualToString:kYoukuRedirectUri]) {
            
            [webView stopLoading];
            
            NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"code=[0-9A-Za-z]+" options:NSRegularExpressionCaseInsensitive error:nil];
            NSTextCheckingResult *result = [regx firstMatchInString:urlString options:0 range:NSMakeRange(0, urlString.length)];
            NSRange foundRange = result.range;
            NSString *foundString = [urlString substringWithRange:foundRange];
            NSString *code = [foundString substringFromIndex:5];
            DLog(@"url = %@", urlString);
            
            NSURL *url = [NSURL URLWithString:kApiYoukuBasePath];
            AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
            NSDictionary *properties = @{@"client_id": kYoukuAppKey,
                                         @"client_secret": kYoukuAppScrect,
                                         @"grant_type": @"authorization_code",
                                         @"code": code,
                                         @"redirect_uri": kYoukuRedirectUriChinese};
            [client postPath:kApiYoukuTokenPath parameters:properties success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                
                [[NSUserDefaults standardUserDefaults] setObject:json forKey:kOAuthCredential];
                [[NSUserDefaults standardUserDefaults] synchronize];

                __weak UINavigationController *nc = (UINavigationController *)[self presentingViewController];
                __weak HLYViewController *vc = (HLYViewController *)[nc topViewController];
                [self dismissViewControllerAnimated:YES completion:^{
                    vc.passValue = NSLocalizedString(@"Auth Success", nil);
                }];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DLog(@"error : %@", error.userInfo);
                
                __weak UINavigationController *nc = (UINavigationController *)[self presentingViewController];
                __weak HLYViewController *vc = (HLYViewController *)[nc topViewController];
                [self dismissViewControllerAnimated:YES completion:^{
                    vc.passValue = NSLocalizedString(@"Auth Failed", nil);
                }];
            }];
        }
    }
    
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    DLog(@"did end with url ===> %@", webView.request);
    NSString *test = [webView.request.URL absoluteString];
    if ([test isEqualToString:kYoukuCallbackUrl]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
