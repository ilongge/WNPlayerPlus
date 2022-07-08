//
//  DetailViewController.m
//  WNPlayer
//
//  Created by apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//
#define RTSP_URL       @"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov"
#define HTTP_MP4       @"http://mov.bn.netease.com/mobilev/open/nos/mp4/2015/12/09/SB9F77DEA_sd.mp4"
#define HTTP_MP4_2     @"https://review.v.news.cn/review/basics/live4958/20200605/0955521822_mp4/095552_1822_5000k.mp4?ut=5ed9af72&us=73284591&sign=e1ad1a1d2d652bc64c7b1e6f594daa11"
#define HTTPS_MOV @"https://b.pan.wo.cn:8443/file?fid=Mjq6NZGVy5L6X6YFcBRW5jeVXoiKbhlrYp/z4FHMdD8=&filename=2021-12-18_151939_000096223.mov&auth=b0d2QWJBaTA5NjQ6wem9aeVplUnE5dUNzd2J6OThEZ2ZYMjVIdEdIZkwvTXA3MElUeWorTEVvST0sMTM5MDMwMTU1NzA=&sign=48a4b520023e28e2k74c46f29b4957416&timestamp=1641798942"
#define HTTP_FLV       @"http://bian-oss.oss-cn-beijing.aliyuncs.com/Video/20201214/1607929647318294.flv"
#define HTTP_WMV       @"http://updatedown.heikeyun.net/WMV%E6%96%87%E4%BB%B6%E8%A7%86%E9%A2%91%E6%B5%8B%E8%AF%95.wmv"

#import "DetailViewController.h"
#import <WNPlayerPlus.h>
@interface DetailViewController ()<WNPlayerDelegate>
@property(nonatomic, strong) WNPlayer *wnPlayer;
@property(nonatomic, strong) WNControlView *customerControlView;
@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setContentMode:UIViewContentModeScaleAspectFill];
   
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
    ];
    self.view.backgroundColor = UIColor.blackColor;
    CGRect rect = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, self.view.frame.size.width*(9/16.0));
    self.wnPlayer = [[WNPlayer alloc] initWithFrame:rect];
    self.wnPlayer.isFullScreen = self.view.frame.size.width > self.view.frame.size.height;
    self.wnPlayer.autoplay = YES;
    self.wnPlayer.delegate = self;
    self.wnPlayer.repeat = NO;
    self.wnPlayer.restorePlayAfterAppEnterForeground = YES;
    //连接设置控制层
    WNControlView *contrlView = [[WNControlView alloc] initWithFrame:self.wnPlayer.bounds];
    contrlView.title = @"测试播放wmv";
    contrlView.coverImageView.image = [UIImage imageNamed:@"Cover"];
    self.wnPlayer.controlView = contrlView;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"4K60-265" ofType:@"mp4"];
    self.wnPlayer.urlString = @"http://111.63.117.13:6060/030000001000/CCTV-4/CCTV-4.m3u8";
    [self.view addSubview:self.wnPlayer];
    [self.wnPlayer play];
    NSLog(@"%@", self.view);
}
-(BOOL)shouldAutorotate{
    return YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
//点击关闭按钮代理方法
-(void)player:(WNPlayer *)player clickedCloseButton:(UIButton *)backBtn{
    if (self.wnPlayer.isFullScreen) {//全屏
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//点击全屏按钮代理方法
-(void)player:(WNPlayer *)player clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (self.wnPlayer.isFullScreen) {//全屏
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }else{//非全屏
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    }
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"--------屏幕旋转--------Home键在上");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"--------屏幕旋转--------Home键在下");
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"--------屏幕旋转--------Home键在左");
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"--------屏幕旋转--------Home键在右");
        }
            break;
        default:
            break;
    }
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGRect rect = CGRectMake(0, statusHeight, size.width, size.width*(9/16.0));
    BOOL isFull = size.width > size.height;
    self.wnPlayer.frame = rect;
    self.wnPlayer.isFullScreen = isFull;
    if (@available(iOS 11.0, *)) {
        [self setNeedsUpdateOfHomeIndicatorAutoHidden];
    }
}
- (void)dealloc{
    [_wnPlayer close];
    NSLog(@"%s",__FUNCTION__);
}
@end
