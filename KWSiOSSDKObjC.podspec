Pod::Spec.new do |s|
  s.name             = "KWSiOSSDKObjC"
  s.version          = "1.3.0.0"
  s.summary          = "The SuperAwesome Kids Web Services SDK"
  s.description      = <<-DESC
The SuperAwesome Kids Web Services iOS SDK
                       DESC

  s.homepage         = "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc"
  s.license          = { :type => "GNU GENERAL PUBLIC LICENSE Version 3", :file => "LICENSE" }
  s.author           = { "Gabriel Coman" => "gabriel.coman@superawesome.tv" }
  s.source           = { :git => "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc.git", :branch => "fix/firebase_130_fix", :tag => "1.3.0.0" }
  s.ios.deployment_target = '7.0'
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'Firebase', '3.3.0' 
  s.dependency 'FirebaseMessaging', '1.1.0'
  s.dependency 'SAJsonParser', '1.2.3'
  s.dependency 'SAUtils', '1.2.7'
  s.dependency 'SANetworking',  '0.1.2'
end
