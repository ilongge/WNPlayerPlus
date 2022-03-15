#
# Be sure to run `pod lib lint WNPlayer-ilongge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
    spec.name             = 'WNPlayer-ilongge'
    spec.version          = '0.0.2'
    spec.summary          = 'A short description of WNPlayer-ilongge.'
    spec.description      = <<-DESC
    基于WNPlayer开发
    原始库地址 https://github.com/zhengwenming/WNPlayer.git
    项目内使用自编译FFMpeg.Framework，版本4.3.3.
    DESC
    
    spec.homepage         = 'https://gitee.com/ilongge/wnplayer-ilongge'
    spec.license          = { :type => 'MIT', :file => 'LICENSE.txt' }
    spec.author           = { 'ilongge' => '1015820857@qq.com' }
    spec.source           = { :git => 'https://gitee.com/ilongge/wnplayer-ilongge.git', :tag => spec.version.to_s }
    
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
    
    spec.source_files = 'WNPlayer-ilongge/Classes/**/*'
    spec.libraries = 'bz2','iconv', 'z'
    spec.frameworks = 'OpenGLES', 'VideoToolbox', 'AudioToolbox', 'MediaPlayer', 'Accelerate'
    spec.vendored_frameworks = 'Frameworks/FFmpeg.framework'
    spec.resource_bundle = {'WNPlayer' => [ 'WNPlayer-ilongge/**/*.{xib,xcassets,json,glsl,strings}' ]}
    spec.public_header_files = 'WNPlayer-ilongge/Classes/Public/*.h'
end
