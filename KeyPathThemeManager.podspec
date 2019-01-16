#
# Be sure to run `pod lib lint KeyPathThemeManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KeyPathThemeManager'
  s.version          = '0.1.0'
  s.summary          = 'An iOS theme manager use Swift 4 KeyPaths'
  s.description      = 'An iOS theme manager use Swift 4 KeyPaths'
  s.homepage         = 'https://github.com/patsluth/KeyPathThemeManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'patsluth' => 'pat.sluth@gmail.com' }
  s.source           = { :git => 'https://github.com/patsluth/KeyPathThemeManager.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/patsluth'
  
  s.swift_version = '4.2'

  s.ios.deployment_target = '9.0'
  
  s.static_framework = true

  s.dependency 'Sluthware'
  
  s.frameworks = 'UIKit'
  
  s.source_files = 'KeyPathThemeManager/Classes/**/*'
  
end
