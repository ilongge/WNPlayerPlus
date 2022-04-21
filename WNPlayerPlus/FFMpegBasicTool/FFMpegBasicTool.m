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

+ (void)showFFmpegInfo
{
    printf("ffmpeg version %s Copyright (c) 2000-2022 the FFmpeg developers\n", FFMPEG_VERSION);
    NSString *configuration = [NSString stringWithUTF8String:avformat_configuration()];
    printf("\tconfiguration: %s\n", [configuration UTF8String]);
    [FFMpegBasicTool showAllLibInfo];
    printf("Hyper fast Audio and Video encoder\n");
}

+ (void)showAllLibInfo {
    int ver_major,ver_minor,ver_micro;
    unsigned version = avcodec_version();
    version = avutil_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tlibavutil     %3d.%2d.%3d\n",ver_major,ver_minor,ver_micro);
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tlibavcodec    %3d.%2d.%3d\n",ver_major,ver_minor,ver_micro);
    version = avformat_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tlibavformat   %3d.%2d.%3d\n",ver_major,ver_minor,ver_micro);
    version = avdevice_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tlibavdevice   %3d.%2d.%3d\n",ver_major,ver_minor,ver_micro);
    version = avfilter_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tlibavfilter   %3d.%2d.%3d\n",ver_major,ver_minor,ver_micro);
    version = swscale_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tlibswscale    %3d.%2d.%3d\n",ver_major,ver_minor,ver_micro);
    version = swresample_version();
    ver_major = (version>>16)&0xff;
    ver_minor = (version>>8)&0xff;
    ver_micro = (version)&0xff;
    printf("\tlibswresample %3d.%2d.%3d\n",ver_major,ver_minor,ver_micro);
}
@end
