//
//  NSString+CaesarCode.m
//  JFLiveApp
//
//  Created by ilongge on 2021/3/15.
//  Copyright © 2021 admin. All rights reserved.
//

#define CaesarEncode @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
#define CaesarDecode @"QtMGiZa6hrj=UDHvEY0ABmpkJwTLcIfqb4e5dOlu-yogVWSC8+PzKXx9s1nF732NR"

#import "NSString+CaesarCode.h"

@implementation NSString (CaesarCode)
+ (NSString*)encodeCaesar:(NSString *)baseString{
    NSString *encodeString = [baseString encodeCaesar];
    return encodeString;
}

+ (NSString*)decodeCaesar:(NSString *)baseString{
    NSString *decodeString = [baseString decodeCaesar];
    return decodeString;
}

- (NSString*)encodeCaesar{
    
    if (self.length) {
        
        NSString *base64hash = CaesarEncode;
        NSString *base64hash_mess = CaesarDecode;
        
        NSMutableString *encodeString = [NSMutableString stringWithString:self];
        
        for (NSInteger index = 0; index < encodeString.length; index++) {
            
            NSRange range = NSMakeRange(index, 1);
            NSString *subhash = [encodeString substringWithRange:range];
            
            NSRange subRange = [base64hash rangeOfString:subhash];
            
            if (subRange.location != NSNotFound) {
                
                NSString *subhash_mess = [base64hash_mess substringWithRange:subRange];
                
                [encodeString replaceCharactersInRange:range withString:subhash_mess];
            }
        }
        
        return encodeString;
    }
    return nil;
}

- (NSString*)decodeCaesar{
    
    if (self.length) {
        
        NSString *base64hash = CaesarDecode;
        NSString *base64hash_mess = CaesarEncode;
        
        NSMutableString *encodeString = [NSMutableString stringWithString:self];
        
        for (NSInteger index = 0; index < encodeString.length; index++) {
            
            NSRange range = NSMakeRange(index, 1);
            
            NSString *subhash = [encodeString substringWithRange:range];
            
            NSRange subRange = [base64hash rangeOfString:subhash];
            
            if (subRange.location != NSNotFound) {
                
                NSString *subhash_mess = [base64hash_mess substringWithRange:subRange];
                
                [encodeString replaceCharactersInRange:range withString:subhash_mess];
                
            }
        }
        
        return encodeString;
    }
    return nil;
}
@end
