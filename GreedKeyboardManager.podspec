#
# Be sure to run `pod lib lint GreedKeyboardManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GreedKeyboardManager"
  s.version          = "0.0.2"
  s.summary          = "A solution for updating UIScrollView out of the the keyboard."

  s.homepage         = "https://github.com/greedlab/GreedKeyboardManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Bell" => "bell@greedlab.com" }
  s.source           = { :git => "https://github.com/greedlab/GreedKeyboardManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
#s.resource_bundles = {
#   'GreedKeyboardManager' => ['Pod/Assets/*.png']
# }
  s.prefix_header_file = 'Pod/Classes/GreedKeyboardManager.pch'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
