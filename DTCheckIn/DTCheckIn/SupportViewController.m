//
//  SupportViewController.m
//  DTCheckIn
//
//  Created by Daniel on 2018/11/24.
//  Copyright © 2018 Daniel. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/ZhipingYang/dingtalk_check_in/issues"]]];
}

@end
