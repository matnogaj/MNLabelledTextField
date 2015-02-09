#
# Be sure to run `pod lib lint MNLabelledTextField.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MNLabelledTextField"
  s.version          = "0.1.0"
  s.summary          = "UITextField subclass that has a label above."
  s.description      = <<-DESC
Text field that display label once the text field contains some characters. Text for the label is taken from the placeholder.
                       DESC
  s.homepage         = "https://github.com/matnogaj/MNLabelledTextField"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Mateusz Nogaj" => "matnogaj@gmail.com" }
  s.source           = { :git => "https://github.com/matnogaj/MNLabelledTextField.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
