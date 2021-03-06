//
//  WNPlayerFrame.h
//  PlayerDemo
//
//  Created by zhengwenming on 2018/10/15.
//  Copyright © 2018年 wenming. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    kWNPlayerFrameTypeNone,
    kWNPlayerFrameTypeVideo,
    kWNPlayerFrameTypeAudio
} WNPlayerFrameType;

@interface WNPlayerFrame : NSObject
@property (nonatomic) WNPlayerFrameType type;
@property (nonatomic) NSData *data;
@property (nonatomic) double position;
@property (nonatomic) double duration;
@end

