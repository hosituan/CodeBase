#
# Be sure to run `pod lib lint CodeBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CodeBase'
  s.version          = '0.0.6'
  s.summary          = 'A short description of CodeBase.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hosituan/CodeBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hosituan' => 'hosituan.work@gmail.com' }
  s.source           = { :git => 'https://github.com/hosituan/CodeBase.git', :tag => s.version.to_s }
  s.social_media_url = 'https://facebook.com/hosituan1'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.2'
  s.source_files = 'CodeBase/**/*'
  
  # s.resource_bundles = {
  #   'CodeBase' => ['CodeBase/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.framework = 'UIKit'
    s.dependency 'SnapKit'
    s.dependency 'CocoaLumberjack/Swift'
    s.dependency 'Kingfisher'
    s.dependency 'KeychainAccess'
    s.dependency 'IQKeyboardManagerSwift', '~> 6.0.4'
    s.dependency 'Localize-Swift'
    s.dependency 'DZNEmptyDataSet'
    s.dependency 'RxSwift',    '~> 4.0'
    s.dependency 'RxCocoa',    '~> 4.0'
    s.dependency 'Moya/RxSwift'
    s.dependency 'SwiftyJSON'
    s.dependency 'Then'
end
