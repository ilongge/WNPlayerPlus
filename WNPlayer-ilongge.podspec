Pod::Spec.new do |spec|
    spec.name             = 'WNPlayer-ilongge'
    spec.version          = '0.0.2'
    spec.summary          = 'A short description of WNPlayer-ilongge.'
    spec.description      = <<-DESC
    '基于WNPlayer开发，原始库地址https://github.com/zhengwenming/WNPlayer.git，项目内使用自编译FFMpeg.Framework，版本4.3.3。'
    DESC
    
    spec.homepage         = 'https://gitee.com/ilongge/wnplayer-ilongge'
    spec.license          = { :type => 'MIT', :file => 'LICENSE.txt' }
    spec.author           = { 'ilongge' => '1015820857@qq.com' }
    spec.source           = { :git => 'https://gitee.com/ilongge/wnplayer-ilongge.git', :tag => spec.version.to_s }
    
    spec.ios.deployment_target = '11.0'
    spec.requires_arc = true
    
    spec.pod_target_xcconfig = {
        'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)',
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    }
    
    spec.user_target_xcconfig = {
        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    }
    
    spec.subspec 'Category' do |ss|
        ss.source_files        = 'WNPlayer-ilongge/Category/*.{h,m}'
        ss.public_header_files = 'WNPlayer-ilongge/Category/Category.h'
    end
    
    spec.subspec 'Codec' do |ss|
        ss.dependency              'WNPlayer-ilongge/Common'
        ss.dependency              'WNPlayer-ilongge/Frame'
        ss.source_files          = 'WNPlayer-ilongge/Codec/*.{h,m}'
        ss.public_header_files   = 'WNPlayer-ilongge/Codec/Codec.h'
        ss.libraries             = 'bz2','iconv', 'z'
        ss.frameworks            = 'AVFoundation', 'AudioToolbox', 'Accelerate'
        ss.vendored_frameworks   = 'Frameworks/FFmpeg.framework'
    end
    
    spec.subspec 'Frame' do |ss|
        ss.source_files        = 'WNPlayer-ilongge/Frame/*.{h,m}'
        ss.public_header_files = 'WNPlayer-ilongge/Frame/Frame.h'
        ss.frameworks          = 'OpenGLES'
    end
    
    spec.subspec 'Common' do |ss|
        ss.source_files        = 'WNPlayer-ilongge/Common/*.{h,m}'
        ss.public_header_files = 'WNPlayer-ilongge/Common/*.h'
    end
    
    spec.subspec 'WNPlayer' do |ss|
        ss.dependency            'WNPlayer-ilongge/Frame'
        ss.dependency            'WNPlayer-ilongge/Codec'
        ss.source_files        = 'WNPlayer-ilongge/WNPlayer/*.{h,m}'
        ss.public_header_files = 'WNPlayer-ilongge/WNPlayer/*.h'
        ss.frameworks          = 'OpenGLES', 'QuartzCore'
    end
    spec.source_files          = 'WNPlayer-ilongge/WNPlayer-ilongge.h'
    spec.public_header_files   = 'WNPlayer-ilongge/WNPlayer-ilongge.h'
    spec.resource_bundle       = {
        'WNPlayer' => [ 'WNPlayer-ilongge/**/*.{xib,xcassets,json,glsl,strings}' ]
    }
end
