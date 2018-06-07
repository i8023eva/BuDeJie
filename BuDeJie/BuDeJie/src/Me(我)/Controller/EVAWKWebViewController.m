//
//  EVAWKWebViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/7.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAWKWebViewController.h"
#import <WebKit/WebKit.h>

/*
 需要导入动态库   系统 使用key-value observing 监听属性
 */

@interface EVAWKWebViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *loadWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation EVAWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.URL];
    /*
     Could not signal service com.apple.WebKit.WebContent: 113: Could not find specified service
     Could not signal service com.apple.WebKit.Networking: 113: Could not find specified service
     添加 cookie 不行,估计是天朝网络问题
     */
//    NSHTTPCookie *cookieWID = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                  @"YES" ,NSHTTPCookieName,
//                                                                  @"YES",NSHTTPCookieValue,
//                                                                  @"NSHTTPCookieOriginURL",NSHTTPCookieDomain,
//                                                                  @"NO",NSHTTPCookiePath,
//                                                                  @"false",@"HttpOnly",
//                                                                  nil]];
//    [request setValue:cookieWID.value forHTTPHeaderField:@"Cookie"];
    [self.loadWebView loadRequest:request];
    
    
    
    [self.loadWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.loadWebView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.loadWebView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.loadWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    self.progressView.progress = self.loadWebView.estimatedProgress;
    self.progressView.hidden = self.loadWebView.estimatedProgress == 1;
    
    self.backButton.enabled = self.loadWebView.canGoBack;
    self.forwardButton.enabled = self.loadWebView.canGoForward;
    self.title = self.loadWebView.title;
}

- (void)dealloc {
    [self.loadWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.loadWebView removeObserver:self forKeyPath:@"canGoBack"];
    [self.loadWebView removeObserver:self forKeyPath:@"title"];
    [self.loadWebView removeObserver:self forKeyPath:@"canGoForward"];
}

- (IBAction)backClick:(UIBarButtonItem *)sender {
    [self.loadWebView goBack];
}

- (IBAction)forwardClick:(UIBarButtonItem *)sender {
    [self.loadWebView goForward];
}

- (IBAction)refreshClick:(UIBarButtonItem *)sender {
    [self.loadWebView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
