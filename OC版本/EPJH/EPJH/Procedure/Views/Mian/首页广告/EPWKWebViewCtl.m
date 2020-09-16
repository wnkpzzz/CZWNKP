//
//  EPWKWebViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPWKWebViewCtl.h"
#import <WebKit/WebKit.h>

#define kWebViewEstimatedProgress @"estimatedProgress"
#define kBackImageName @"backItemImage"
#define kBackImageNameHL @"backItemImageHL"
#define kItemSize 44.f
#define kBackWidth 46.f

//扩展
@interface NSArray (Extension)

- (BOOL)exsit:(id)obj;

@end

@implementation NSArray (Extension)

- (BOOL)exsit:(id)object{
    
    for (id obj in self) {
        if (obj == object) {
            return true;
        }
    }
    return false;
}

@end


@interface EPWKWebViewCtl ()<WKNavigationDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIBarButtonItem * backItem;

@property(nonatomic,strong)UIBarButtonItem * closeItem;

@property(nonatomic,strong)NSMutableArray * leftItems;

@property(nonatomic,strong)WKWebView * webView;

@property(nonatomic,strong)UIProgressView * progressView;
 

@end

@implementation EPWKWebViewCtl


#pragma mark - 生命周期

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    //加载请求
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    //监听estimatedProgress
    [_webView addObserver:self forKeyPath:kWebViewEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    
    //隐藏progressView
    [self.view addSubview:self.progressView];
    self.progressView.hidden = true;
     
    
    //左items
    self.leftItems = [NSMutableArray arrayWithObject:self.backItem];
    
    self.closeItem.tintColor = self.navigationController.navigationBar.tintColor;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = !_webView.canGoBack;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_progressView removeFromSuperview];
    _progressView = nil;
    _closeItem = nil;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:kWebViewEstimatedProgress];
}


#pragma mark - 逻辑处理

- (void)setType:(WKWebViewType)type{
    
    _type = type;
 
    switch (type) {
        case WebViewTypeAbout:
            NSLog(@"111");
            break;
        case WebViewTypeHelp:
             NSLog(@"222");
             break;
        case WebViewTypeYinSi:
            NSLog(@"333");
            break;
        case WebViewTypeXieYi:
             NSLog(@"444");
             break;
        case WebViewTypeMZSM:
            NSLog(@"555");
            break;
        case WebViewTypeSYAD:
             NSLog(@"666");
             break;
        default:
            break;
    }
}


#pragma mark - 懒加载

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
        _webView.navigationDelegate = self;//有关导航事件的委托代理
        _webView.allowsBackForwardNavigationGestures = true;//打开右滑回退功能
//        self.view = _webView;
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.frame = CGRectMake(0, 0, APP_WIDTH, 2);
        _progressView.tintColor = [UIColor greenColor];
        [self.navigationController.view addSubview:_progressView];
    }
    return _progressView;
}

- (UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        
        UIButton * close = [UIButton buttonWithType:UIButtonTypeSystem];
        [close setTitle:@"关闭" forState:UIControlStateNormal];
        close.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        close.frame = CGRectMake(0, 0, kItemSize, kItemSize);
        close.tintColor = self.navigationController.navigationBar.tintColor;
        [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
         _closeItem = [[UIBarButtonItem alloc]initWithCustomView:close];
        
    }
    return _closeItem;
}
 
- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        
        UIButton * back = [UIButton buttonWithType:UIButtonTypeSystem];
        [back setImage:[UIImage imageNamed:kBackImageName] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:kBackImageNameHL] forState:UIControlStateHighlighted];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        back.frame = CGRectMake(0, 0, kBackWidth, kItemSize);
        back.tintColor = self.navigationController.navigationBar.tintColor;
        [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
        
    }
    return _backItem;
}

#pragma mark - 事件处理

- (void)setLeftItems:(NSMutableArray *)leftItems{
    _leftItems = leftItems;
    //显示左按钮
    [self setLeftItems];
}

- (void)setLeftItems{
    self.navigationItem.leftBarButtonItems = _leftItems;
}

- (void)showCloseItem{
    NSLog(@"Show");
    if (![_leftItems exsit:_closeItem]) {
        [self.leftItems addObject:_closeItem];
    }
    [self setLeftItems];
}

- (void)hiddenCloseItem{
    NSLog(@"Hidden");
    if ([_leftItems exsit:_closeItem]) {
        [self.leftItems removeObject:_closeItem];
    }
    [self setLeftItems];
}

- (void)close:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)back:(UIBarButtonItem *)sender{
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self close:nil];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    _progressView.progress = _webView.estimatedProgress;
}
 
#pragma mark - WKNavigationDelegate

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _progressView.hidden = false;
}

//内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
- (void)popGestureRecognizerEnable{

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        if ([self.navigationController.viewControllers count] == 2) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
        
    }
}

//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    _progressView.hidden = true;
    self.title = _webView.title;
    
    if (!_webView.canGoBack) {
        [self popGestureRecognizerEnable];
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = !_webView.canGoBack;
    
    if (_webView.canGoForward) {
        [self showCloseItem];
    }else{
        [self hiddenCloseItem];
    }
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    _progressView.hidden = true;
    
}

@end
