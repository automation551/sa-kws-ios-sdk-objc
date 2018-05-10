Pod::Spec.new do |s|
  s.name             = "KWSiOSSDKObjC"
  s.version          = "3.0.0"
  s.summary          = "The SuperAwesome Kids Web Services SDK"
  s.description      = <<-DESC
The SuperAwesome Kids Web Services iOS SDK
                       DESC

  s.homepage         = "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc"
  s.license          = { 
	:type => "GNU GENERAL PUBLIC LICENSE Version 3", 
	:file => "LICENSE" 
  }
  s.author           = { 
	"Gabriel Coman" => "gabriel.coman@superawesome.tv" 
  }
  s.source           = { 
	:git => "https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc.git", 
	:branch => "master", 
	:tag => "#{s.version}" 
  }
  s.ios.deployment_target = '9.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.2' }
  s.source_files = 'KWSiOSSDKObjC/Classes/**/*'
  s.dependency 'SAMobileBase', '2.2.3'
  s.dependency 'SAProtobufs', '1.6.5'
  
end
