//
//  WNControlViewProtocol.h
//  WNPlayer
//
//  Created by apple on 2019/11/15.
//  Copyright © 2019 apple. All rights reserved.
//

@class WNPlayer;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WNControlViewProtocol <NSObject>

@required

@property (nonatomic,weak) WNPlayer *player;

-(void)play;
-(void)pause;
-(void)singleTaped;
-(void)doubleTaped;
@end

NS_ASSUME_NONNULL_END
