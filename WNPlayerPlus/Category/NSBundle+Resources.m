//
//  NSBundle+GDResources.m
//  GDProjectUI
//
//  Created by dev on 2018/11/5.
//  Copyright © 2018 dev. All rights reserved.
//

#import "NSBundle+Resources.h"
#import "ProjectResourcesManager.h"
@implementation NSBundle (GDResources)

+ (NSBundle *)resourcesBundle {
    static dispatch_once_t onceToken;
    static NSBundle *resourcesBundle = nil;
    if (resourcesBundle == nil) {
        NSBundle *currrentBundle = [NSBundle bundleForClass:[ProjectResourcesManager class]];
        NSString *buntdlePath = [currrentBundle pathForResource:@"WNPlayerPlus" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:buntdlePath];
        dispatch_once(&onceToken, ^{
            resourcesBundle = bundle;
        });
    }
    return resourcesBundle;
}

@end
