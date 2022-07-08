//
//  ProjectResourcesManager.m
//
//  Created by ilongge on 2021/11/01.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ProjectResourcesManager.h"
#import "CategoryHeader.h"

@implementation ProjectResourcesManager

+ (UIImage *)imageWithName:(NSString *)name{
    if (name.length) {
        NSBundle *bundle = [NSBundle resourcesBundle];
        UIImage *image = [UIImage imageNamed:name
                                    inBundle:bundle
               compatibleWithTraitCollection:nil];
        return image;
    }
    return nil;
}

+ (UINib *)nibWith:(NSString *)nibName
{
    UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle resourcesBundle]];
    
    return nib;
}

@end

