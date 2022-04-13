Pod::Spec.new do |s|
  s.name = "WNPlayerPlus"
  s.version = "1.0.0"
  s.summary = "A short description of WNPlayerPlus."
  s.license = {"type"=>"MIT", "file"=>"LICENSE.txt"}
  s.authors = {"ilongge"=>"1015820857@qq.com"}
  s.homepage = "https://github.com/ilongge/WNPlayerPlus"
  s.description = "'\u57FA\u4E8EWNPlayer\u5F00\u53D1\uFF0C\u539F\u59CB\u5E93\u5730\u5740https://github.com/zhengwenming/WNPlayer.git\uFF0C\u9879\u76EE\u5185\u4F7F\u7528\u81EA\u7F16\u8BD1FFMpeg.Framework\uFF0C\u7248\u672C4.3.3\u3002'"
  s.frameworks = ["AVFoundation", "AudioToolbox", "VideoToolbox", "Accelerate", "OpenGLES", "QuartzCore"]
  s.libraries = ["bz2", "iconv", "z"]
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/WNPlayerPlus.framework'
end
