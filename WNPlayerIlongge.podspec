Pod::Spec.new do |spec|
    spec.name             = 'WNPlayerIlongge'
    spec.version          = '1.0.1'
    spec.summary          = 'A short description of WNPlayer-ilongge.'
    spec.description      = <<-DESC
    '基于WNPlayer开发，原始库地址https://github.com/zhengwenming/WNPlayer.git，项目内使用自编译FFMpeg.Framework，版本4.3.3。'
    DESC
    
    spec.homepage         = 'https://github.com/ilongge/wnplayer-ilongge'
    spec.license          = { :type => 'MIT', :file => 'LICENSE.txt' }
    spec.author           = { 'ilongge' => '1015820857@qq.com' }
    spec.source           = { :git => 'https://github.com/ilongge/wnplayer-ilongge.git', :tag => spec.version.to_s }
    
    spec.ios.deployment_target = '9.0'
    spec.requires_arc = true
    
    spec.pod_target_xcconfig = {
        'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)',
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    }
    
    spec.user_target_xcconfig = {
        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    }
    spec.vendored_frameworks   = 'Frameworks/FFmpeg.framework'
    spec.libraries             = 'bz2','iconv', 'z'
    spec.frameworks            = 'AVFoundation', 'AudioToolbox', 'VideoToolbox', 'Accelerate', 'OpenGLES', 'QuartzCore'
    spec.source_files          = 'WNPlayerIlongge/**/*.{h,m}'
    spec.public_header_files   = 'WNPlayerIlongge/WNPlayer-ilongge.h','WNPlayerIlongge/WNPlayer/*.h'
    spec.resource_bundle       = {
        'WNPlayer' => [ 'WNPlayerIlongge/**/*.{xib,xcassets,json,glsl,strings}' ]
    }
end
