//
//  DefineHeader.h
//  Pods
//
//  Created by ilongge on 2021/11/1.
//

#ifndef DefineHeader_h
#define DefineHeader_h

#pragma mark - FontName

#define BoldFontName                    @"PingFang-SC-Medium"
#define FontName                        @"PingFang-SC-Regular"

#pragma mark - WeakSelf/StrongSelf

#define WeakSelf(weakSelf)              __weak __typeof(&*self) weakSelf = self;
#define StrongSelf(strongSelf)          __strong __typeof(&*self) strongSelf = weakSelf;
 
//状态栏高度  20  44
#define kStatusBarHeight                [[UIApplication sharedApplication] statusBarFrame].size.height
/*导航栏高度*/
#define kNaviBarHeight                   44.0
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight               (CGFloat)(kStatusBarHeight>20?(kNaviBarHeight):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight               (CGFloat)(kStatusBarHeight>20?(34.0):(0))
/*状态栏和导航栏总高度*/
#define kNaviHeight                     (CGFloat)(kNaviBarHeight+kStatusBarHeight)
/*TabBar高度*/
#define kTabBarHeight                   (CGFloat)(49.0 + kBottomSafeHeight)

//屏幕宽度与高度
#define kSCREEN_WIDTH                   [UIScreen mainScreen].bounds.size.width

#define kSCREEN_HEIGHT                  [UIScreen mainScreen].bounds.size.height

#define kWINDOW                         [[UIApplication sharedApplication] keyWindow]

/// 设置RGB颜色
#define RGB_COLOR(r,g,b)                     RGB_COLOR_ALPHA(r,g,b,1.0)
#define RGB_COLOR_ALPHA(r,g,b,a)             [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB_Hex(hex)                      RGB_Hex_Alpha(hex ,1)
#define RGB_Hex_Alpha(hex ,a)                      [UIColor colorWithRed:((float)((hex &0xFF0000)>>16))/255.0 green:((float)((hex &0xFF00)>>8))/255.0 blue:((float)(hex &0xFF))/255.0 alpha:a]

#define ColorWhite                           RGB_Hex(0xFFFFFF)
#define ColorBlack                           RGB_Hex(0x000000)
#define Color333333                          RGB_Hex(0x333333)
#define Color777777                          RGB_Hex(0x777777)
#define Color38C0EE                          RGB_Hex(0x38C0EE)
#define Color18E0D7                          RGB_Hex(0x18E0D7)
#define Color85D6F2                          RGB_Hex(0x85D6F2)
#define ColorB2B2B2                          RGB_Hex(0xB2B2B2)
#define ColorD8D8D8                          RGB_Hex(0xD8D8D8)
#define ColorEFEFEF                          RGB_Hex(0xEFEFEF)
#define ColorF6F6F6                          RGB_Hex(0xF6F6F6)
#define ColorF0F0F0                          RGB_Hex(0xF0F0F0)

#define PLog(format,...)  printf("[%s] %s.%d %s\n",[[NSDate date] dateStringWithFormatter:@"yy-MM-dd HH:mm:ss.SSS"].UTF8String,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,[[NSString stringWithFormat:format,## __VA_ARGS__] UTF8String]);

#define NSLog(format,...) printf("[%s] %s.%d %s\n",[[NSDate date] dateStringWithFormatter:@"yy-MM-dd HH:mm:ss.SSS"].UTF8String,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,[[NSString stringWithFormat:format,## __VA_ARGS__] UTF8String]);



#endif /* DefineHeader_h */
