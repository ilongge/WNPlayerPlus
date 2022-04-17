//
//  NSString+CaesarCode.h
//  JFLiveApp
//
//  Created by ilongge on 2021/3/15.
//  Copyright © 2021 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CaesarCode)
/// 凯撒加密
+ (NSString*)encodeCaesar:(NSString *)baseString;
/// 凯撒解密
+ (NSString*)decodeCaesar:(NSString *)baseString;

/// 凯撒加密
- (NSString*)encodeCaesar;
/// 凯撒解密
- (NSString*)decodeCaesar;

@end

 
