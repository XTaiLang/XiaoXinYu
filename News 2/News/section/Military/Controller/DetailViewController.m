//
//  DetailViewController.m
//  News
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "DetailViewController.h"
#import "AllHeaders.h"
#import "AppDelegate.h"
#import "NewsBase.h"
#import <CoreData/CoreData.h>
#import <UMSocial.h>
#define kWhigthL ([UIScreen mainScreen].bounds.size.width-50*3)/4

@interface DetailViewController ()<UIWebViewDelegate, UIScrollViewDelegate, UMSocialUIDelegate>

@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, copy) NSString *nameString;

@property (nonatomic, copy) NSString *contentString;

@property (nonatomic, strong) UIView *playView;

@property (nonatomic, strong) NSString *image;

@end

@implementation DetailViewController


- (UIView *)playView
{
    if (!_playView) {
        
        self.playView  = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49)];
        
        self.playView.backgroundColor = [UIColor whiteColor];
        
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        backButton.frame = CGRectMake(kWhigthL, 5, 50, 40);
        
        backButton.backgroundColor = [UIColor clearColor];
        
       //  UIImage *image = [UIImage imageNamed:@"back"];
        
        // image.
        
        [backButton setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        
        
        
        [backButton addTarget:self action:@selector(handleBack:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.playView addSubview:backButton];
        
        UIButton *likeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        likeButton.frame = CGRectMake(2*kWhigthL + 50, 5, 50, 40);
        
        likeButton.backgroundColor = [UIColor clearColor];
        
        [likeButton setImage:[UIImage imageNamed:@"love"] forState:(UIControlStateNormal)];
        
        [likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.playView addSubview:likeButton];
        
        UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        shareButton.frame = CGRectMake(3*kWhigthL + 100, 5, 50, 40);
        
        shareButton.backgroundColor = [UIColor clearColor];
        
        [shareButton setImage:[UIImage imageNamed:@"share1"] forState:(UIControlStateNormal)];
        
        [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.playView addSubview:shareButton];
        
        
    }
    return _playView;
}





- (void)shareButtonAction:(UIButton *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:self];
}







- (void)handleBack:(UIButton *)sender{
    
   
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
}


- (void)likeButtonAction:(UIButton *)sender
{
//     NSLog(@"收藏");
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NewsBase" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"aid"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    
    NSArray *fetchedObjects = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
//    NSLog(@"%@",error);
    
    if (fetchedObjects == nil) {
    
//        
//        NewsBase *base = [NSEntityDescription insertNewObjectForEntityForName:@"NewsBase" inManagedObjectContext:delegate.managedObjectContext];
//        
//        base.aid = self.aid;
//        
//        base.title = self.titleString;
//        
//        base.image = self.image;
//        
//        [delegate saveContext];
//        
//        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"你可以在收藏里查看" preferredStyle:(UIAlertControllerStyleAlert)];
//        
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:nil];
        
        
//        NSLog(@"收藏成功");
        
    }else{
        
        BOOL falg = YES;

        for (NewsBase *base in fetchedObjects) {
            
            if (base.aid == self.aid) {
                
                falg = NO;
                
                
                
                
            }
            
            
            
           
        }
        
        if (falg == YES) {
            
            NewsBase *base = [NSEntityDescription insertNewObjectForEntityForName:@"NewsBase" inManagedObjectContext:delegate.managedObjectContext];
            
            base.aid = self.aid;
            
            base.title = self.titleString;
            
            base.image = self.image;
            
            [delegate saveContext];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"你可以在收藏里查看" preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];

//            NSLog(@"收藏成功");

            
        } else {
        
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏失败" message:@"已经被收藏" preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
//            NSLog(@"已经收藏过了");
        
        }
        
    }

}










- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataFromeNet];
    
    [(UIScrollView *)[[self.DetailView subviews] objectAtIndex:0] setBounces:NO];
    
    self.navigationController.navigationBarHidden = YES;
    
     UIScrollView *tempView=(UIScrollView *)[self.DetailView.subviews objectAtIndex:0];
    
    
    
     tempView.delegate = self;
    
    
    
    self.DetailView.delegate = self;
    // Do any additional setup after loading the view.
    
}




#pragma mark - 滚动视图代理方法

static CGFloat currrntY = - 100;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (currrntY < scrollView.contentOffset.y) {
        
        [UIView animateWithDuration:0.7 animations:^{
            
            self.playView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49);
        }];
        
    }
    else {
        
        [UIView animateWithDuration:0.7 animations:^{
            
            self.playView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        }];
    }
    currrntY = scrollView.contentOffset.y;
    //    NSLog(@"%f", currrntY);
}




- (void)loadDataFromeNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString *str = [NSString stringWithFormat:kDetail, self.aid];
    
//     NSLog(@"%@", str);
    
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
        self.titleString = responseObject[@"title"];
        
        self.image = responseObject[@"shareImg"];
        
        // NSLog(@"%@", self.image);
        
        self.titlelabel.text = self.titleString;
        
        self.nameString = responseObject[@"authorNickName"];
        
        self.namelabel.text = [NSString stringWithFormat:@"%@   %@", self.nameString, self.dateString];
        
        self.contentString = responseObject[@"webContent"];
        
        NSMutableString *body = [NSMutableString string];
        
        [body appendFormat:@"<div><head><style>img{width:%fpx !important;}</style></head>%@</div>",[UIScreen mainScreen].bounds.size.width - 20 , self.contentString];
        
        [self.DetailView loadHTMLString:body baseURL:nil];
        
        [self.view addSubview:self.playView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
}

/*
- (NSString *)contentstringS
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\"style=\"color:black;text-align:center;font-size:20px;font-weight:bold;background-color:white\">%@</div>",self.titleString];
    
    //    [imgHtml appendString:@"<div class=\"img-parent\">"];
    
    [body appendFormat:@"<div class=\"time\"style=\"color:gray;font-size:14px;background-color:white\">%@ &nbsp;&nbsp %@</div>", self.nameString, self.dateString];
    
    
    [body appendFormat:@"<div><head><style>img{width:%fpx !important;}</style></head>%@</div>",[UIScreen mainScreen].bounds.size.width - 20 , self.contentString];
    return body;
}
 */



//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSString *js = @"function imgAutoFit() { \
//    var imgs = document.getElementsByTagName(\"img\"); \
//    for (var i = 0; i < imgs.length; ++i) {\
//    var img = imgs[i];   \
//    img.style.maxWidth = %f;   \
//    } \
//    }";
//    
//    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
//    
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
//    
//}





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
