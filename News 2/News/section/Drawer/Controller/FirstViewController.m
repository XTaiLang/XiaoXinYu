//
//  FirstViewController.m
//  News
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "FirstViewController.h"
#import "RootViewController.h"
@interface FirstViewController ()<UIScrollViewDelegate>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kImageCount 3
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@property (weak, nonatomic) IBOutlet UIImageView *imageL;
@property (weak, nonatomic) IBOutlet UIScrollView *scrrowView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageL.userInteractionEnabled = YES;
    
    self.scrrowView.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [self.imageL addGestureRecognizer:tap];
    
    
    
    [self configurePageControl];
    
    [self.view addSubview:self.scrrowView];
    
    [self.view addSubview:self.pageControl];
    // Do any additional setup after loading the view.
}


- (void)configurePageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(0, kScreenHeight - 40, kScreenWidth, 30))];
    
    
    _pageControl.numberOfPages = kImageCount;
    
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    
    _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    
    
    
    [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}



- (void)pageControlAction:(UIPageControl *)sender
{
    NSInteger number = sender.currentPage;
    
    _scrrowView.contentOffset = CGPointMake(kScreenWidth * number, 0);
}


- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RootViewController *rootVC = [st instantiateViewControllerWithIdentifier:@"rootVC"];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = rootVC;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat number = offset.x/kScreenWidth;
    
    _pageControl.currentPage = (NSInteger)number;
    
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
