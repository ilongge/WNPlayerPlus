//
//  WNPlayerFrame.h
//  PlayerDemo
//
//  Created by zhengwenming on 2018/10/15.
//  Copyright © 2018年 wenming. All rights reserved.
//

@class WNPlayerVideoFrame;

#import <UIKit/UIKit.h>

@interface WNDisplayView : UIView
@property (nonatomic,assign) CGSize contentSize;
@property (nonatomic,assign) CGFloat rotation;
@property (nonatomic,assign) BOOL isYUV;
@property (nonatomic,assign) BOOL keepLastFrame;
/**
 * 渲染尺寸
 */
+ (UIImage *)glToUIImage:(CGSize)size;
/**
 * 渲染范围
 */
- (void)render:(WNPlayerVideoFrame *)frame;
/**
 * 清理显示内容
 */
- (void)clear;
@end

