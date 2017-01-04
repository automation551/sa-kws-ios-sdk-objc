Pod::Spec.new do |s|
  s.name             = "KWSiOSSDKObjC"
  s.version          = "2.1.10"
  s.summary          = "The SuperAwesome Kids Web Services SDK"
  s.description      = <<-DESC
The SuperAwesome Kids Web Services iOS SDK
                       DESC

  s.homepage         = "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc"
  s.license          = { :type => "GNU GENERAL PUBLIC LICENSE Version 3", :file => "LICENSE" }
  s.author           = { "Gabriel Coman" => "gabriel.coman@superawesome.tv" }
  s.source           = { :git => "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc.git", :branch => "master", :tag => "2.1.10" }
  s.ios.deployment_target = '7.0'
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'SAJsonParser', '1.3.1'
  s.dependency 'SAUtils', '1.4.7'
  s.dependency 'SANetworking',  '0.2.8'
end
