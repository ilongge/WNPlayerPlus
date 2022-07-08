//
//  NSString+Json.m
//  JFCloundChat
//
//  Created by ilongge on 2021/11/30.
//

#import "NSString+Json.h"

@implementation NSString (Json)
/**
 格式化json
 */
+ (NSString *)formatJson:(NSString *)json
{
    NSString *newJson = [json formatJson];
    return newJson;
}
/**
 格式化json
 */
- (NSString *)formatJson
{
    NSInteger depth = 0;
    NSString *space = @"  ";
    NSMutableString *formated = [NSMutableString string];
    [formated appendString:@"\n"];
    for (int i=0; i<self.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%@",[self substringWithRange:NSMakeRange(i, 1)]];
        if ([c isEqualToString:@"{"]) {
            depth+=1;
            [formated appendString:c];
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
        }else if ([c isEqualToString:@"}"]) {
            depth-=1;
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
            [formated appendString:c];
        }else if ([c isEqualToString:@","]) {
            [formated appendString:c];
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
        }else if ([c isEqualToString:@"["]) {
            depth+=1;
            [formated appendString:c];
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
        }else if ([c isEqualToString:@"]"]) {
            depth-=1;
            [formated appendString:@"\n"];
            for (int j=0; j<depth; j++) {
                [formated appendString:space];
            }
            [formated appendString:c];
        }else{
            [formated appendString:c];
        }
    }
    return [NSString stringWithString:formated];
}
@end
