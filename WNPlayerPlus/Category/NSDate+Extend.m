//
//  NSDate+Extend.m
//  JFLiveApp
//
//  Created by ilongge on 2021/7/23.
//  Copyright © 2021 admin. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)
/// 给定格式转换时间戳
- (NSString *)dateStringWithFormatter:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterString;
    formatter.timeZone = [NSTimeZone systemTimeZone];
    return [formatter stringFromDate:self];
}

/// 时间戳-->年月日
+ (NSString *)dateStringWith:(NSTimeInterval)timeInterval
                andFormatter:(NSString *)formatterString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [date dateStringWithFormatter:formatterString];
    return dateString;
}

/// 给定格式转换时间戳
+ (NSTimeInterval)timeIntervalFor:(NSString *)dateString
                 andDateFormatter:(NSString *)formatterString
{
    NSDate *date = [NSDate dateFor:dateString andDateFormatter:formatterString];
    NSTimeInterval time = [date timeIntervalSince1970];
    return time;
}

+ (NSString *)formatDataStringFor:(NSTimeInterval)timeInterval
                        andFormat:(NSString *)dateFormat
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
/// 给定格式转换日期
+ (NSDate *)dateFor:(NSString *)dateString
   andDateFormatter:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterString;
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

/// 转换日期格式
+ (NSString *)orginDateString:(NSString *)orginString
        andOrginDateFormatter:(NSString *)orginFormatterString
       andTargetDateFormatter:(NSString *)targetDateFormatter
{
    NSDate *date = [NSDate dateFor:orginString
                  andDateFormatter:orginFormatterString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = targetDateFormatter;
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


/// 精简格式化输出
+ (NSString *)reduceDateString:(NSString *)dateString
              andDateFormatter:(NSString *)formatterString
{
    NSTimeInterval messageTimeInterval = [NSDate timeIntervalFor:dateString andDateFormatter:formatterString];
    
    NSString *reduce = [NSDate reduceDateTimeInterval:messageTimeInterval];
    
    return reduce;
}

/// 精简格式化输出
+ (NSString *)reduceDateTimeInterval:(NSTimeInterval)timeInterval
{
    NSString *reduceDateString;
    
    NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
    // 年
    NSString *yearString = [NSDate formatDataStringFor:timeInterval andFormat:@"yyyy"];
    NSString *nowYearString = [NSDate formatDataStringFor:nowTimeInterval andFormat:@"yyyy"];
    
    NSTimeInterval yeartimeInterval = [NSDate timeIntervalFor:yearString andDateFormatter:@"yyyy"];
    NSTimeInterval yearNowTimeInterval = [NSDate timeIntervalFor:nowYearString andDateFormatter:@"yyyy"];
    // 跨年了
    if (yearNowTimeInterval > yeartimeInterval) {
        reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"yyyy-MM-dd HH:mm"];
    }
    else{
        // 月
        NSString *monthString = [NSDate formatDataStringFor:timeInterval andFormat:@"yyyy-MM"];
        NSString *nowMonthString = [NSDate formatDataStringFor:nowTimeInterval andFormat:@"yyyy-MM"];
        
        NSTimeInterval monthTimeInterval = [NSDate timeIntervalFor:monthString andDateFormatter:@"yyyy-MM"];
        NSTimeInterval monthNowTimeInterval = [NSDate timeIntervalFor:nowMonthString andDateFormatter:@"yyyy-MM"];
        // 跨月了
        if (monthNowTimeInterval > monthTimeInterval) {
            reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"MM-dd HH:mm"];
        }
        else{
            // 天
            NSString *dayString = [NSDate formatDataStringFor:timeInterval andFormat:@"yyyy-MM-dd"];
            NSString *nowDayString = [NSDate formatDataStringFor:nowTimeInterval andFormat:@"yyyy-MM-dd"];
            
            NSTimeInterval dayTimeInterval = [NSDate timeIntervalFor:dayString andDateFormatter:@"yyyy-MM-dd"];
            NSTimeInterval dayNowTimeInterval = [NSDate timeIntervalFor:nowDayString andDateFormatter:@"yyyy-MM-dd"];
            NSInteger day = (dayNowTimeInterval - dayTimeInterval)/86400;
            switch (day) {
                case 0:
                    reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"HH:mm"];
                    break;
                case 1:
                    reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"昨天 HH:mm"];
                    break;
                case 2:
                    reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"前天 HH:mm"];
                    break;
                case 3:
                case 4:
                case 5:
                case 6:
                {
                    // 天
                    NSString *weekString = [NSDate formatDataStringFor:timeInterval andFormat:@"e"];
                    reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"%@ HH:mm"];
                    switch (weekString.integerValue) {
                        case 1:
                            reduceDateString = [NSString stringWithFormat:reduceDateString,@"周日"];
                            break;
                        case 2:
                            reduceDateString = [NSString stringWithFormat:reduceDateString,@"周一"];
                            break;
                        case 3:
                            reduceDateString = [NSString stringWithFormat:reduceDateString,@"周二"];
                            break;
                        case 4:
                            reduceDateString = [NSString stringWithFormat:reduceDateString,@"周三"];
                            break;
                        case 5:
                            reduceDateString = [NSString stringWithFormat:reduceDateString,@"周四"];
                            break;
                        case 6:
                            reduceDateString = [NSString stringWithFormat:reduceDateString,@"周五"];
                            break;
                        case 7:
                            reduceDateString = [NSString stringWithFormat:reduceDateString,@"周六"];
                            break;
                        default:
                            reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"MM-dd HH:mm"];
                            break;
                    }
                }
                    break;
                default:
                    reduceDateString = [NSDate formatDataStringFor:timeInterval andFormat:@"MM-dd HH:mm"];
                    break;
            }
        }
    }
    return reduceDateString;
}

@end
