Pod::Spec.new do |s|
  s.name             = "KWSiOSSDKObjC"
  s.version          = "2.3.0"
  s.summary          = "The SuperAwesome Kids Web Services SDK"
  s.description      = <<-DESC
The SuperAwesome Kids Web Services iOS SDK
                       DESC

  s.homepage         = "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc"
  s.license          = { :type => "GNU GENERAL PUBLIC LICENSE Version 3", :file => "LICENSE" }
  s.author           = { "Gabriel Coman" => "gabriel.coman@superawesome.tv" }
  s.source           = { :git => "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc.git", :branch => "master", :tag => "2.3.0" }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'SAJsonParser', '1.3.2'
  s.dependency 'SAUtils', '1.5.0'
  s.dependency 'SANetworking',  '0.2.9'
end
