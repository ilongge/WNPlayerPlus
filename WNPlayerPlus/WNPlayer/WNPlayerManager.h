//
//  WNPlayerFrame.h
//  PlayerDemo
//
//  Created by zhengwenming on 2018/10/15.
//  Copyright © 2018年 wenming. All rights reserved.
//

@class WNDisplayView;

#import <Foundation/Foundation.h>

typedef void (^onPauseComplete)(void);

NS_ASSUME_NONNULL_BEGIN

@interface WNPlayerManager : NSObject
@property (nonatomic, strong) WNDisplayView *displayView;
@property (nonatomic, assign) double minBufferDuration;
@property (nonatomic, assign) double maxBufferDuration;
@property (nonatomic, assign) double position;
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) BOOL opened;
@property (nonatomic, assign) BOOL playing;
@property (nonatomic, assign) BOOL buffering;
@property (nonatomic, assign) BOOL mute;
@property (nonatomic, strong) NSDictionary *metadata;

- (void)open:(NSString *)url usesTCP:(BOOL)usesTCP optionDic:(NSDictionary *)optionDic;
/**
 * 时移
 */
- (void)seek:(double)position;
/**
 * 关闭播放器
 */
- (void)close;
/**
 * 开始播放
 */
- (void)play;
/**
 * 暂停
 */
- (void)pause;
/**
 * 静音 OR 播放
 */
- (BOOL)muteVoice;
@end

NS_ASSUME_NONNULL_END
