//
//  UIDevice+Extension.m

//
//  Created by Liyn on 2018/9/17.
//  Copyright © 2018年 Liyn. All rights reserved.
//

#import "UIDevice+Extension.h"
#import <sys/sysctl.h>
@implementation UIDevice (Extension)
+ (NSString *)getCurrentDeviceModelDescription{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine
                                            encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}
// 获取设备型号然后手动转化为对应名称
+ (NSString *)getCurrentDeviceModel{
    
    NSString *platform = [UIDevice getCurrentDeviceModelDescription];
    
    if([platform isEqualToString:@"iPhone3,1"])return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"])return @"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"])return @"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])return @"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"])return @"iPhone 5";
    if([platform isEqualToString:@"iPhone5,3"])return @"iPhone 5c";
    if([platform isEqualToString:@"iPhone5,4"])return @"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])return @"iPhone 5s";
    if([platform isEqualToString:@"iPhone6,2"])return @"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])return @"iPhone 6 Plus";
    if([platform isEqualToString:@"iPhone7,2"])return @"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])return @"iPhone 6s";
    if([platform isEqualToString:@"iPhone8,2"])return @"iPhone 6s Plus";
    if([platform isEqualToString:@"iPhone8,4"])return @"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])return @"iPhone 7";
    if([platform isEqualToString:@"iPhone9,2"])return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone9,3"])return @"iPhone 7";
    if([platform isEqualToString:@"iPhone9,4"])return @"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"])return @"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"])return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,5"])return @"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,3"])return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"])return @"iPhone X";
    
    if([platform isEqualToString:@"iPhone11,2"])return @"iPhone XS";
    if([platform isEqualToString:@"iPhone11,4"])return @"iPhone XS Max";
    if([platform isEqualToString:@"iPhone11,6"])return @"iPhone XS Max";
    if([platform isEqualToString:@"iPhone11,8"])return @"iPhone XR";
    
    if([platform isEqualToString:@"iPhone12,1"])return @"iPhone 11";
    if([platform isEqualToString:@"iPhone12,3"])return @"iPhone 11 Pro";
    if([platform isEqualToString:@"iPhone12,5"])return @"iPhone 11 Pro Max";
    
    if([platform isEqualToString:@"iPhone13,1"])return @"iPhone 12 mini";
    if([platform isEqualToString:@"iPhone13,2"])return @"iPhone 12";
    if([platform isEqualToString:@"iPhone13,3"])return @"iPhone 12 Pro";
    if([platform isEqualToString:@"iPhone13,4"])return @"iPhone 12 Pro Max";
    
    if([platform isEqualToString:@"iPhone14,1"])return @"iPhone 13 mini";
    if([platform isEqualToString:@"iPhone14,2"])return @"iPhone 13";
    if([platform isEqualToString:@"iPhone14,3"])return @"iPhone 13 Pro";
    if([platform isEqualToString:@"iPhone14,4"])return @"iPhone 13 Pro Max";
    
    if([platform isEqualToString:@"iPod1,1"])return @"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])return @"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])return @"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])return @"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])return @"iPod Touch(5 Gen)";
    
    if([platform isEqualToString:@"iPad1,1"])return @"iPad";
    if([platform isEqualToString:@"iPad1,2"])return @"iPad 3G";
    
    if([platform isEqualToString:@"iPad2,1"])return @"iPad 2";
    if([platform isEqualToString:@"iPad2,2"])return @"iPad 2";
    if([platform isEqualToString:@"iPad2,3"])return @"iPad 2";
    if([platform isEqualToString:@"iPad2,4"])return @"iPad 2";
    if([platform isEqualToString:@"iPad2,5"])return @"iPad Mini";
    if([platform isEqualToString:@"iPad2,6"])return @"iPad Mini";
    if([platform isEqualToString:@"iPad2,7"])return @"iPad Mini";
    
    if([platform isEqualToString:@"iPad3,1"])return @"iPad 3";
    if([platform isEqualToString:@"iPad3,2"])return @"iPad 3";
    if([platform isEqualToString:@"iPad3,3"])return @"iPad 3";
    if([platform isEqualToString:@"iPad3,4"])return @"iPad 4";
    if([platform isEqualToString:@"iPad3,5"])return @"iPad 4";
    if([platform isEqualToString:@"iPad3,6"])return @"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])return @"iPad Air";
    if([platform isEqualToString:@"iPad4,2"])return @"iPad Air";
    if([platform isEqualToString:@"iPad4,4"])return @"iPad Mini 2";
    if([platform isEqualToString:@"iPad4,5"])return @"iPad Mini 2";
    if([platform isEqualToString:@"iPad4,6"])return @"iPad Mini 2";
    if([platform isEqualToString:@"iPad4,7"])return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,8"])return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,9"])return @"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])return @"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,2"])return @"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,3"])return @"iPad Air 2";
    if([platform isEqualToString:@"iPad5,4"])return @"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,4"])return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,7"])return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,8"])return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,11"])return @"iPad 5";
    if([platform isEqualToString:@"iPad6,12"])return @"iPad 5";
    
    if([platform isEqualToString:@"iPad7,1"])return @"iPad Pro 12.9 inch 2nd gen";
    if([platform isEqualToString:@"iPad7,2"])return @"iPad Pro 12.9 inch 2nd gen";
    if([platform isEqualToString:@"iPad7,3"])return @"iPad Pro 10.5 inch";
    if([platform isEqualToString:@"iPad7,4"])return @"iPad Pro 10.5 inch";
    
    if([platform isEqualToString:@"AppleTV2,1"])return @"Apple TV 2";
    if([platform isEqualToString:@"AppleTV3,1"])return @"Apple TV 3";
    if([platform isEqualToString:@"AppleTV3,2"])return @"Apple TV 3";
    if([platform isEqualToString:@"AppleTV5,3"])return @"Apple TV 4";
    
    if([platform isEqualToString:@"i386"])return @"Simulator";
    if([platform isEqualToString:@"x86_64"])return @"Simulator";
    return platform;
}
// 输出信息
+ (void)printSystemAllInfo
{
    // 创建系统进程信息对象
    NSProcessInfo* processInfo = [NSProcessInfo processInfo];
    // 返回当前进程的参数
    //NSArray* arguments = [processInfo arguments];
    // 返回当前的环境变量
    //NSDictionary* environmentDict = [processInfo environment];
    // 返回进程标识符
    int processId = [processInfo processIdentifier];
    // 返回进程数量
    //NSUInteger count = [processInfo processorCount];
    // 返回活动的进程数量
    //NSUInteger activeCount = [processInfo activeProcessorCount];
    // 返回正在执行的进程名称
    NSString* processName = [processInfo processName];
    // 生成单值临时文件名
    //NSString* uniqueStr = [processInfo globallyUniqueString];
    // 返回主机系统的名称
    //NSString* hostName = [processInfo hostName];
    // 返回操作系统的版本号
    //NSOperatingSystemVersion osVersion = [processInfo operatingSystemVersion];
    // 返回操作系统名称
    NSString* osName = [processInfo operatingSystemVersionString];
    // 判断系统版本是否高于某个版本
    //NSOperatingSystemVersion osVersion1 = {10, 10, 4};
    //BOOL isFirst = [processInfo isOperatingSystemAtLeastVersion:osVersion1];
    // 返回系统运行时间
    NSTimeInterval timeInterval = [processInfo systemUptime]; 
    NSLog(@"进程名称：%@", processName);
    NSLog(@"进程号：%d", processId);
    NSLog(@"系统版本：%@", osName);
    NSLog(@"系统运行时长:%lf", timeInterval);
}
@end
