//
//  BlockHeader.h
//
//  Created by ilongge on 2020/5/25.
//  Copyright © 2020 admin. All rights reserved.
//

#ifndef BlockHeader_h
#define BlockHeader_h

typedef void(^EmptyBlock)(void);

typedef void(^IndexPathBlock)(NSIndexPath *indexPath);

typedef void(^IndexStrBlock)(NSInteger index,NSString *s);

typedef void(^IntBlock)(int intValue);

typedef void(^FloatBlock)(float floatValue);

typedef void(^CGFloatBlock)(CGFloat CGFloatValue);

typedef void(^NSStringBlock)(NSString *stringValue);

typedef void(^UIImageBlock)(UIImage *imageValue);

typedef void(^NSNumberBlock)(NSNumber *numberValue);

typedef void(^BoolBlock)(BOOL boolValue);

typedef void(^NSIntegerBlock)(NSInteger integerValue);

typedef void(^URLBlock)(NSURL *urlValue);

typedef void(^DictionaryHandler)(NSDictionary *dictionary);

typedef void(^ArrayHandler)(NSArray *array);

#endif /* BlockHeader_h */
