//
//  NSString+Json.h
//  JFCloundChat
//
//  Created by ilongge on 2021/11/30.
//

#import <Foundation/Foundation.h>

@interface NSString (Json)
/**
 格式化json
 */
+ (NSString *)formatJson:(NSString *)json;
/**
 格式化json
 */
- (NSString *)formatJson;
@end


