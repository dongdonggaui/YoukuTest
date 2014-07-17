//
//  HLYVideoPlayViewController.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>

#import "HLYVideoPlayViewController.h"

@interface HLYVideoPlayViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (NSString *)md5:(NSString *)str;

@end

@implementation HLYVideoPlayViewController

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
    double timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString *videoId = [self.passValue isKindOfClass:[NSString class]] ? self.passValue : [self.passValue objectForKey:@"id"];
    NSString *toBeMD5 = [NSString stringWithFormat:@"%@_%lf_%@", videoId, timeStamp, kYoukuAppScrect];
    NSString *embsig = [NSString stringWithFormat:@"%@_%lf_%@", @"1", timeStamp, [self md5:toBeMD5]];
    NSString *html = [NSString stringWithFormat:@"<div id=\"youkuplayer\"></div><script type=\"text/javascript\" src=\"http://player.youku.com/jsapi\">player = new YKU.Player('youkuplayer',{client_id: '%@',vid: '%@',autoplay: false,embsig: '%@',show_related: false,width: 300,height: 200,events:{onPlayerReady: function(){ /*your code*/ },onPlayStart: function(){ /*your code*/ },onPlayEnd: function(){ /*your code*/ }}});</script>", kYoukuAppKey, videoId, embsig];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ]; 
    
}

@end
