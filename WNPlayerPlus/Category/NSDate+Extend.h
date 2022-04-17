//
//  NSDate+Extend.h
//  JFLiveApp
//
//  Created by ilongge on 2021/7/23.
//  Copyright © 2021 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extend)
/// 时间戳-->年月日
- (NSString *)dateStringWithFormatter:(NSString *)formatterString;

/// 时间戳-->年月日
+ (NSString *)dateStringWith:(NSTimeInterval)timeInterval
                andFormatter:(NSString *)formatterString;

/// 年月日-->时间戳
+ (NSTimeInterval)timeIntervalFor:(NSString *)dateString
                 andDateFormatter:(NSString *)formatterString;

/// 年月日-->NSDate
+ (NSDate *)dateFor:(NSString *)dateString
   andDateFormatter:(NSString *)formatterString;

/// 转换日期格式
+ (NSString *)orginDateString:(NSString *)orginString
        andOrginDateFormatter:(NSString *)orginFormatterString
       andTargetDateFormatter:(NSString *)targetDateFormatter;

/// 精简格式化输出
+ (NSString *)reduceDateString:(NSString *)dateString
              andDateFormatter:(NSString *)formatterString;

/// 精简格式化输出
+ (NSString *)reduceDateTimeInterval:(NSTimeInterval)timeInterval;
@end

NS_ASSUME_NONNULL_END
