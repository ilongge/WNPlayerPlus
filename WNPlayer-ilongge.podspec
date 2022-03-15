#
# Be sure to run `pod lib lint WNPlayer-ilongge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'WNPlayer-ilongge'
s.version          = '0.0.1'
s.summary          = 'A short description of WNPlayer-ilongge.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'https://github.com/1015820857@qq.com/WNPlayer-ilongge'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '1015820857@qq.com' => '1015820857@qq.com' }
s.source           = { :git => 'https://github.com/1015820857@qq.com/WNPlayer-ilongge.git', :tag => s.version.to_s }

s.ios.deployment_target = '9.0'
s.requires_arc = true

s.pod_target_xcconfig = {
'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)',
'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
}

s.user_target_xcconfig = {
'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
}

s.source_files = 'WNPlayer-ilongge/Classes/**/*'
s.libraries = 'bz2','iconv', 'z'
s.frameworks = 'OpenGLES', 'VideoToolbox', 'AudioToolbox', 'MediaPlayer', 'Accelerate'
s.vendored_frameworks = 'Frameworks/FFmpeg.framework'
s.resource_bundle = {'WNPlayer' => [ 'WNPlayer-ilongge/**/*.{xib,xcassets,json,glsl,strings}' ]}
s.public_header_files = 'WNPlayer-ilongge/Classes/Public/*.h'
end
