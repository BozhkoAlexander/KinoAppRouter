#
# Be sure to run `pod lib lint KinoAppRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KinoAppRouter'
  s.version          = '0.1.1'
  s.summary          = 'KinoAppRouter is module for routing inside a kino app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
KinoAppRouter is module for routing inside a kino app, which uses universal page with different configs.
                       DESC

  s.homepage         = 'https://github.com/BozhkoAlexander/KinoAppRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BozhkoAlexander' => 'alexander.bozhko@filmgrail.com' }
  s.source           = { :git => 'https://github.com/BozhkoAlexander/KinoAppRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.source_files = 'KinoAppRouter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KinoAppRouter' => ['KinoAppRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
