//
//  FFMpegBasicTool.m
//  Pods-WNPlayer-ilongge_Example
//
//  Created by ilongge on 2022/4/2.
//

#import "FFMpegBasicTool.h"
// FFMpeg
#import <FFMpeg/FFMpeg.h>

@implementation FFMpegBasicTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)showFFmpegInfo
{
    printf("FFMpeg -%s\n", FFMPEG_VERSION);
    NSString *configuration = [NSString stringWithUTF8String:avformat_configuration()];
    configuration = [configuration stringByReplacingOccurrencesOfString:@"--" withString:@"\n\t--"];
    printf("BuildConfiguration%s\n", [configuration UTF8String]);
    
    printf("\n");
    int ver_major,ver_minor,ver_micro;
    unsigned version = avcodec_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tavcodec version    %3d.%3d.%3d\n",ver_major,ver_minor,ver_micro);
    
    version = avformat_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tavformat version   %3d.%3d.%3d\n",ver_major,ver_minor,ver_micro);
    
    version = avfilter_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tavfilter version   %3d.%3d.%3d\n",ver_major,ver_minor,ver_micro);
    
    version = avutil_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tavutil version     %3d.%3d.%3d\n",ver_major,ver_minor,ver_micro);
    
    version = swscale_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tswscale version    %3d.%3d.%3d\n",ver_major,ver_minor,ver_micro);
    
    version = avdevice_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tavdevice version   %3d.%3d.%3d\n",ver_major,ver_minor,ver_micro);
    
    version = swresample_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tswresample version %3d.%3d.%3d\n",ver_major,ver_minor,ver_micro);
    
//    printf("%s", avcodec_configuration());
}

@end
