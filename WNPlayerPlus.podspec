#
# Be sure to run `pod lib lint WNPlayerPlus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
    spec.name             = 'WNPlayerPlus'
    spec.version          = '1.0.0'
    spec.summary          = 'A short description of WNPlayerPlus.'
    spec.description      = <<-DESC
    '基于WNPlayer开发，原始库地址https://github.com/zhengwenming/WNPlayer.git，项目内使用自编译FFMpeg.Framework，版本4.3.3。'
    DESC
    
    spec.homepage         = 'https://github.com/ilongge/WNPlayerPlus'
    spec.license          = { :type => 'MIT', :file => 'LICENSE.txt' }
    spec.author           = { 'ilongge' => '1015820857@qq.com' }
    spec.source           = { :git => 'https://github.com/ilongge/WNPlayerPlus.git', :tag => spec.version.to_s }
    
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
    spec.source_files          = 'WNPlayerPlus/**/*.{h,m}'
    spec.public_header_files   = 'WNPlayerPlus/WNPlayerPlus.h','WNPlayerPlus/WNPlayer/*.h'
    spec.resource_bundle       = {
        'WNPlayerPlus' => [ 'WNPlayerPlus/**/*.{xib,xcassets,json,glsl,strings}' ]
    }
end
