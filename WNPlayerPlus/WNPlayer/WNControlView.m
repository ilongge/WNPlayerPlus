//
//  WNControlView.m
//  WNPlayer
//
//  Created by apple on 2019/11/15.
//  Copyright © 2019 apple. All rights reserved.
//

#define WNPlayerImage(file)            [ProjectResourcesManager imageWithName:file]
#import "ProjectResourcesManager.h"
#import "WNControlView.h"
#import "WNPlayer.h"
#import "WNDisplayView.h"
#import "WNPlayerDef.h"
#import "WNPlayerManager.h"
#import "ConfigHeader.h"
#import "WNPlayerUtils.h"

@interface WNControlView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *backItemView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *bottomView;
//显示播放时间的UILabel+加载失败的UILabel+播放视频的title
@property (nonatomic, strong) UILabel  *leftTimeLabel;
@property (nonatomic, strong) UILabel  *rightTimeLabel;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *loadFailedLabel;
@property (nonatomic, strong) UISlider *progressSlider;
//控制全屏和播放暂停按钮
@property (nonatomic, strong) UIButton *fullScreenButton;
@property (nonatomic, strong) UIButton *playOrPauseButton;
@property (nonatomic, strong) UIButton *lockButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *rateButton;
@property (nonatomic, strong) UIButton *muteButton;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign) BOOL slideOutside;
@property (nonatomic, assign) BOOL sliderValueChanged;
//格式化时间（懒加载防止多次重复初始化）
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@end

@implementation WNControlView
@synthesize player = _player;

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    }
    return _dateFormatter;
}
- (NSString *)convertTime:(float)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [self.dateFormatter setDateFormat:@"HH:mm:ss"];
    } else {
        [self.dateFormatter setDateFormat:@"mm:ss"];
    }
    return [self.dateFormatter stringFromDate:d];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.coverImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.coverImageView];
        
        self.topView = [[UIImageView alloc]initWithImage:WNPlayerImage(@"top_shadow")];
        self.topView.userInteractionEnabled = YES;
        self.topView.clipsToBounds = NO;
        [self addSubview:self.topView];
        
        self.backItemView = [UIView new];
        [self.topView addSubview:self.backItemView];
        
        UITapGestureRecognizer *tapBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseVideo:)];
        tapBack.numberOfTapsRequired = 1;
        tapBack.numberOfTouchesRequired = 1;
        [self.backItemView addGestureRecognizer:tapBack];
        
        //backButton
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton.showsTouchWhenHighlighted = YES;
        [self.backButton setImage:WNPlayerImage(@"player_icon_nav_back") forState:UIControlStateNormal];
        [self.backButton setImage:WNPlayerImage(@"player_icon_nav_back") forState:UIControlStateSelected];
        [self.backButton addTarget:self action:@selector(colseVideo:) forControlEvents:UIControlEventTouchUpInside];
        [self.backItemView addSubview:self.backButton];
        
        // Title Label
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.hidden = YES;//为了不影响用户观看视频，title默认隐藏，获取更大的视频视野面积
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:self.titleLabel];
        
        self.loadFailedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        self.loadFailedLabel.hidden = YES;
        self.loadFailedLabel.text = @"视频加载失败";
        self.loadFailedLabel.textAlignment = NSTextAlignmentCenter;
        self.loadFailedLabel.backgroundColor = [UIColor clearColor];
        self.loadFailedLabel.font = [UIFont systemFontOfSize:14];
        self.loadFailedLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.loadFailedLabel];
        
        //bottomView
        self.bottomView = [[UIImageView alloc]initWithImage:WNPlayerImage(@"bottom_shadow")];
        self.bottomView.userInteractionEnabled = NO;
        [self addSubview:self.bottomView];
        
        // Play/Pause Button
        self.playOrPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playOrPauseButton.showsTouchWhenHighlighted = YES;
        [self.playOrPauseButton addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
        [self.playOrPauseButton setImage:WNPlayerImage(@"player_ctrl_icon_pause") forState:UIControlStateNormal];
        [self.playOrPauseButton setImage:WNPlayerImage(@"player_ctrl_icon_play") forState:UIControlStateSelected];
        [self.bottomView addSubview:self.playOrPauseButton];
        
        // leftTimeLabel
        self.leftTimeLabel = [[UILabel alloc] init];
        self.leftTimeLabel.backgroundColor = [UIColor clearColor];
        self.leftTimeLabel.text = @"00:00";
        self.leftTimeLabel.font = [UIFont systemFontOfSize:10];
        self.leftTimeLabel.textColor = [UIColor whiteColor];
        [self.bottomView addSubview:self.leftTimeLabel];
        
        // rightTimeLabel
        self.rightTimeLabel = [[UILabel alloc] init];
        self.rightTimeLabel.backgroundColor = [UIColor clearColor];
        self.rightTimeLabel.text = @"00:00";
        self.rightTimeLabel.font = [UIFont systemFontOfSize:10];
        self.rightTimeLabel.textColor = [UIColor whiteColor];
        self.rightTimeLabel.textAlignment = NSTextAlignmentRight;
        [self.bottomView addSubview:self.rightTimeLabel];
        
        //fullScreenButton
        self.fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fullScreenButton.showsTouchWhenHighlighted = YES;
        [self.fullScreenButton addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fullScreenButton setImage:WNPlayerImage(@"player_icon_fullscreen") forState:UIControlStateNormal];
        [self.fullScreenButton setImage:WNPlayerImage(@"player_icon_fullscreen") forState:UIControlStateSelected];
        [self.bottomView addSubview:self.fullScreenButton];
        
        self.muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.muteButton.showsTouchWhenHighlighted = YES;
        [self.muteButton addTarget:self action:@selector(muteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.muteButton setImage:WNPlayerImage(@"player_ctrl_icon_voice") forState:UIControlStateNormal];
        [self.muteButton setImage:WNPlayerImage(@"player_ctrl_icon_mute") forState:UIControlStateSelected];
        [self.bottomView addSubview:self.muteButton];
        //slider
        self.progressSlider = [UISlider new];
        self.progressSlider.minimumValue = 0.0;
        self.progressSlider.maximumValue = 1.0;
        self.progressSlider.continuous = YES;
        [self.progressSlider setThumbImage:WNPlayerImage(@"dot")  forState:UIControlStateNormal];
        self.progressSlider.minimumTrackTintColor = self.tintColor?self.tintColor:[UIColor greenColor];
        self.progressSlider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        self.progressSlider.backgroundColor = [UIColor clearColor];
        self.progressSlider.value = 0.0;//指定初始值
        [self.progressSlider addTarget:self action:@selector(onSliderStartSlide:) forControlEvents:UIControlEventTouchDown];
        //进度条的拖拽事件
        [self.progressSlider addTarget:self action:@selector(onSliderValueChanged:)  forControlEvents:UIControlEventValueChanged];
        //进度条的点击事件
        [self.progressSlider addTarget:self action:@selector(onSliderEndSlide:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        //给进度条添加单击手势
        //        self.progressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
        //        self.progressTap.delegate = self;
        //        [self.progressSlider addGestureRecognizer:self.progressTap];
        [self.bottomView addSubview:self.progressSlider];
        
        self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:self.loadingView];
        self.loadingView.hidesWhenStopped = YES;
        [self.loadingView startAnimating];
        
        self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesutreRecognizer:)];
        self.singleTap.numberOfTapsRequired = 1;
        self.singleTap.numberOfTouchesRequired = 1;
        self.singleTap.delegate = self;
        [self.singleTap setDelaysTouchesBegan:YES];
        [self addGestureRecognizer:self.singleTap];
        
        self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesutreRecognizer:)];
        self.doubleTap.numberOfTapsRequired = 2;
        self.doubleTap.numberOfTouchesRequired = 1;
        self.doubleTap.delegate = self;
        [self.doubleTap setDelaysTouchesBegan:YES];
        [self addGestureRecognizer:self.doubleTap];
        
        [self.singleTap requireGestureRecognizerToFail:self.doubleTap];//如果双击成立，则取消单击手势（双击的时候不会走单击事件）
    }
    return self;
}
#pragma mark - Gesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIControl class]]) {
        return NO;
    }
    return YES;
}
#pragma mark - hiddenControlView
- (void)hiddenControlView{
    if (self.animating) return;
    self.animating = YES;
    [UIView animateWithDuration:0.5f
                     animations:^{
        self.topView.frame = CGRectMake(self.topView.frame.origin.x, -self.topView.frame.size.height, self.topView.frame.size.width, self.topView.frame.size.height);
        self.bottomView.frame = CGRectMake(self.bottomView.frame.origin.x, self.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
        self.slideOutside = YES;
    }
                     completion:^(BOOL finished) {
        self.animating = NO;
    }];
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}
-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    self.progressSlider.minimumTrackTintColor = self.tintColor;
}
- (void)showControlView {
    if (self.animating) return;
    self.animating = YES;
    [UIView animateWithDuration:0.5f
                     animations:^{
        if (kStatusBarHeight > 24) {
            if (self.player.isFullScreen) {
                self.topView.frame = CGRectMake(0, 0, self.frame.size.width, 120);
                self.bottomView.frame = CGRectMake(0, self.frame.size.height-50-44, self.frame.size.width, 50+44);
                
            }else{
                self.topView.frame = CGRectMake(0, 0, self.frame.size.width, 64);
                self.bottomView.frame = CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50);
            }
        }else{//非刘海屏
            self.topView.frame = CGRectMake(0, 0, self.frame.size.width, 84);
            if (self.player.isFullScreen) {
                self.bottomView.frame = CGRectMake(0, self.frame.size.height-50-30, self.frame.size.width, 50+30);
            }else{
                self.bottomView.frame = CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50);
            }
        }
        self.slideOutside = NO;
    }
                     completion:^(BOOL finished) {
        self.animating = NO;
    }];
}
-(void)autoDismissControlView{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenControlView) object:nil];
    [self performSelector:@selector(hiddenControlView) withObject:nil afterDelay:5.0];
}
#pragma mark - Gesture
- (void)onTapGesutreRecognizer:(UITapGestureRecognizer *)recognizer {
    if (recognizer==self.singleTap) {
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            if (self.slideOutside) {
                [self showControlView];
                [self autoDismissControlView];
            }else {
                [self hiddenControlView];
            }
        }
        if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(player:singleTaped:)]) {
            [self.player.delegate player:self.player singleTaped:recognizer];
        }
    }else{
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            [self playOrPause:self.playOrPauseButton];
        }
        if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(player:doubleTaped:)]) {
            [self.player.delegate player:self.player doubleTaped:recognizer];
        }
    }
}
//close Button action
-(void)colseVideo:(UIButton *)sender{
    if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(player:clickedCloseButton:)]) {
        [self.player.delegate player:self.player clickedCloseButton:sender];
    }
}
//fullScreen Button action
-(void)fullScreenAction:(UIButton *)sender{
    if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(player:clickedFullScreenButton:)]) {
        [self.player.delegate player:self.player clickedFullScreenButton:sender];
    }
}
//playOrPauseButton action
- (void)playOrPause:(UIButton *)sender {
    if (self.player.playerManager.playing) {
        [self.player.playerManager pause];
        self.playOrPauseButton.selected = YES;
    } else {
        [self.player.playerManager play];
        self.playOrPauseButton.selected = NO;
    }
    if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(player:clickedPlayOrPauseButton:)]) {
        [self.player.delegate player:self.player clickedPlayOrPauseButton:sender];
    }
}
- (void)muteAction:(UIButton *)button {
    BOOL mute = [self.player.playerManager muteVoice];
    self.muteButton.selected = mute;
}
#pragma mark WNControlViewProtocol
- (void)play{
    [self playOrPause:self.playOrPauseButton];
}
- (void)pause{
    [self playOrPause:self.playOrPauseButton];
}
-(void)singleTaped{
    [self onTapGesutreRecognizer:self.singleTap];
}
-(void)doubleTaped{
    
}
- (void)onSliderStartSlide:(UISlider *)sender {
    self.singleTap.enabled = NO;
    self.sliderValueChanged = YES;
}
- (void)onSliderValueChanged:(UISlider *)slider {
    float position = slider.value;
    self.leftTimeLabel.text = [self convertTime:position];
    self.sliderValueChanged = YES;
    self.progressSlider.value = position;
    
}
- (void)onSliderEndSlide:(UISlider *)slider {
    float position = slider.value;
    self.player.playerManager.position = position;
    self.singleTap.enabled = YES;
    self.sliderValueChanged = NO;
    self.progressSlider.value = position;
}
-(void)syncScrubber:(NSNumber *)position{
    int seconds = ceil(position.doubleValue);
    self.leftTimeLabel.text = [self convertTime:seconds];
    if (!self.sliderValueChanged) {
        self.progressSlider.value = seconds;
    }
}
-(void)playerReadyToPlay:(WNPlayer *)player{
    if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(playerReadyToPlay:videoSize:)]) {
        [self.player.delegate playerReadyToPlay:self.player videoSize:self.player.playerManager.displayView.contentSize];
    }
    self.bottomView.userInteractionEnabled = YES;
    double duration = player.playerManager.duration;
    int seconds = ceil(duration);
    self.rightTimeLabel.text = [self convertTime:player.playerManager.duration];
    self.progressSlider.enabled = seconds > 0;
    self.progressSlider.maximumValue = seconds;
    self.progressSlider.minimumValue = 0;
    self.progressSlider.value = 0;
    [self autoDismissControlView];
    self.coverImageView.hidden = YES;
    self.loadFailedLabel.hidden = YES;
}
-(void)playerBufferStateChanged:(NSNumber *)info{
    BOOL state = [info boolValue];
    if (state){
        [self.loadingView startAnimating];
    } else {
        [self.loadingView stopAnimating];
    }
}
-(void)playerEOF:(WNPlayer *_Nonnull)player{
    if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(playerFinishedPlay:)]) {
        [self.player.delegate playerFinishedPlay:player];
    }
}
-(void)playerError:(NSError *)error{
    if (self.player.delegate&&[self.player.delegate respondsToSelector:@selector(playerFailedPlay:error:)]) {
        [self.player.delegate playerFailedPlay:self.player error:error];
    }
    if ([error.domain isEqualToString:WNPlayerErrorDomainDecoder]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingView stopAnimating];
            self.bottomView.userInteractionEnabled = YES;
            self.loadFailedLabel.hidden = NO;
        });
        NSLog(@"Player decoder error: %@", error);
    } else if ([error.domain isEqualToString:WNPlayerErrorDomainAudioManager]) {
        NSLog(@"Player audio error: %@", error);
        // I am not sure what will cause the audio error,
        // if it happens, please issue to me
    }
}
-(void)playerIsFullScreen:(NSNumber *_Nonnull)isFullScreen{
    if (isFullScreen.boolValue) {
        self.titleLabel.hidden = NO;
    }else{
        self.titleLabel.hidden = YES;
    }
}
#pragma mark layoutSubviews
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonWidth = 32;
    BOOL isStatusBarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if (isStatusBarHidden) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        CGFloat height = MAX(size.width, size.height);
        CGFloat width = MIN(size.width, size.height);
        if (width >= 375) {
            if ( (height / width) > (667.000000 / 375.000000)) {
                statusBarHeight = 44;
            }
            else{
                statusBarHeight = 24;
            }
        }
        else{
            statusBarHeight = 24;
        }
    }
    // 刘海屏
    if (statusBarHeight > 24) {
        if (self.player.isFullScreen) {
            self.topView.frame = CGRectMake(0, 0, self.frame.size.width, 120);
            self.bottomView.frame = CGRectMake(0, self.frame.size.height-50-44, self.frame.size.width, 50+44);
            self.playOrPauseButton.frame = CGRectMake(10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.leftTimeLabel.frame = CGRectMake(15, 0, 45, 20);
            self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.leftTimeLabel.frame), 0, self.bottomView.frame.size.width-2*(CGRectGetMaxX(self.leftTimeLabel.frame)), 20);
            self.rightTimeLabel.frame = CGRectMake(self.frame.size.width-self.leftTimeLabel.frame.size.width-15, self.leftTimeLabel.frame.origin.y, self.leftTimeLabel.frame.size.width, self.leftTimeLabel.frame.size.height);
            self.fullScreenButton.frame = CGRectMake(self.bottomView.frame.size.width-buttonWidth-10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.muteButton.frame = CGRectMake(CGRectGetMidX(self.bottomView.frame) - buttonWidth / 2.0, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
        }else{
            self.topView.frame = CGRectMake(0, 0, self.frame.size.width, 64);
            self.bottomView.frame = CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50);
            self.playOrPauseButton.frame = CGRectMake(10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.leftTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.playOrPauseButton.frame)+10, 0, 45, self.bottomView.frame.size.height);
            self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.leftTimeLabel.frame), 0, self.bottomView.frame.size.width-2*(CGRectGetMaxX(self.leftTimeLabel.frame))- buttonWidth - 5, self.bottomView.frame.size.height);
            self.rightTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.progressSlider.frame), self.leftTimeLabel.frame.origin.y, self.leftTimeLabel.frame.size.width, self.leftTimeLabel.frame.size.height);
            self.muteButton.frame = CGRectMake(self.bottomView.frame.size.width-buttonWidth-10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.fullScreenButton.frame = CGRectMake(CGRectGetMinX(self.muteButton.frame) - buttonWidth - 5, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
        }
    }
    // 非刘海屏
    else{
        self.topView.frame = CGRectMake(0, 0, self.frame.size.width, 84);
        if (self.player.isFullScreen) {
            self.bottomView.frame = CGRectMake(0, self.frame.size.height-50-30, self.frame.size.width, 50+30);
            self.playOrPauseButton.frame = CGRectMake(10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.leftTimeLabel.frame = CGRectMake(15, 0, 45, 20);
            self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.leftTimeLabel.frame), 0, self.bottomView.frame.size.width-2*(CGRectGetMaxX(self.leftTimeLabel.frame)), 20);
            self.rightTimeLabel.frame = CGRectMake(self.frame.size.width-self.leftTimeLabel.frame.size.width-15, self.leftTimeLabel.frame.origin.y, self.leftTimeLabel.frame.size.width, self.leftTimeLabel.frame.size.height);
            self.fullScreenButton.frame = CGRectMake(self.bottomView.frame.size.width-buttonWidth-10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.muteButton.frame = CGRectMake(CGRectGetMidX(self.bottomView.frame) - buttonWidth / 2.0, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
        }else{
            self.bottomView.frame = CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50);
            self.playOrPauseButton.frame = CGRectMake(10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.leftTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.playOrPauseButton.frame)+10, 0, 45, self.bottomView.frame.size.height);
            self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.leftTimeLabel.frame), 0, self.bottomView.frame.size.width-2*(CGRectGetMaxX(self.leftTimeLabel.frame))- buttonWidth - 5, self.bottomView.frame.size.height);
            self.rightTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.progressSlider.frame), self.leftTimeLabel.frame.origin.y, self.leftTimeLabel.frame.size.width, self.leftTimeLabel.frame.size.height);
            self.muteButton.frame = CGRectMake(self.bottomView.frame.size.width-buttonWidth-10, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
            self.fullScreenButton.frame = CGRectMake(CGRectGetMinX(self.muteButton.frame) - buttonWidth - 5, self.bottomView.frame.size.height/2-buttonWidth/2, buttonWidth, buttonWidth);
        }
    }
    self.coverImageView.frame = self.bounds;
    self.backItemView.frame = CGRectMake(0, 0, 50, self.topView.frame.size.height);
    self.backButton.frame = CGRectMake(10, (self.backItemView.frame.size.height-self.backButton.currentImage.size.height)/2.0f, buttonWidth, buttonWidth);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.backItemView.frame)+10, 0, self.topView.frame.size.width-10-self.backItemView.frame.size.width-80, self.topView.frame.size.height);
    self.loadingView.center = CGPointMake(self.frame.size.width/2-self.loadingView.frame.size.width/2, self.frame.size.height/2-self.loadingView.frame.size.height/2);
    self.loadFailedLabel.frame = CGRectMake(self.frame.size.width/2-self.loadFailedLabel.frame.size.width/2, self.frame.size.height/2-self.loadFailedLabel.frame.size.height/2, self.loadFailedLabel.frame.size.width, self.loadFailedLabel.frame.size.height);
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

@end
