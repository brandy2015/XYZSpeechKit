#
#  Be sure to run `pod spec lint XYZSpeechKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "XYZSpeechKit"
  s.version      = "1.0.5"
  s.summary      = "持续升级"

  s.description  = <<-DESC
                    简洁调用一些方法

                   DESC

  s.homepage     = "https://github.com/brandy2015/XYZSpeechKit"
   
  s.license      = "MIT"

  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  s.ios.deployment_target = '13.0'
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Brandy" => "" }
  s.authors            = { "Brandy" => "zhangqianbrandy2012@gmail.com" }
  s.platform     = :ios, "13.0"
  s.source       = { :git => "https://github.com/brandy2015/XYZSpeechKit.git", :tag => "1.0.5"}
  s.source_files = "XYZSpeechKit/Classes/*"
 
 
 
  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
 
end
