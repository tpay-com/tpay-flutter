#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tpay.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_tpay'
  s.version          = '1.2.10'
  s.summary          = 'Tpay Flutter iOS bridge'
  s.description      = <<-DESC
  Tpay Flutter iOS bridge'.
                       DESC
  s.homepage         = 'https://tpay.com/'
  s.license          = { :type => "MIT", :file => "../LICENSE" }
  s.author           = 'Tpay'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Tpay-SDK', '1.3.9'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
