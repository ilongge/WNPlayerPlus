//
//  UIDevice+Extension.h
 
//
//  Created by Liyn on 2018/9/17.
//  Copyright © 2018年 Liyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extension)
/*
 获取设备描述
 */
+ (NSString *)getCurrentDeviceModelDescription;
/*
 由获取到的设备描述，来匹配设备型号
 */
+ (NSString *)getCurrentDeviceModel;
/*
 输出信息
 */
+ (void)printSystemAllInfo;
@end
