#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "WNPlayerPlus.h"
#import "WNControlView.h"
#import "WNControlViewProtocol.h"
#import "WNDisplayView.h"
#import "WNPlayer.h"
#import "WNPlayerManager.h"

FOUNDATION_EXPORT double WNPlayerPlusVersionNumber;
FOUNDATION_EXPORT const unsigned char WNPlayerPlusVersionString[];

