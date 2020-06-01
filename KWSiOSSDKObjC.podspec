Pod::Spec.new do |s|
  s.name             = 'KWSiOSSDKObjC'
  s.version          = '3.1.4'
  s.summary          = 'The SuperAwesome Kids Web Services SDK'
  s.swift_version    = '4.2'
  s.description      = <<-DESC
The SuperAwesome Kids Web Services iOS SDK
                       DESC

  s.homepage         = 'https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc'
  s.license          = {
	:type => 'GNU LESSER GENERAL PUBLIC LICENSE Version 3',
	:file => 'LICENSE'
  }
  s.author           = {
	'Gabriel Coman' => 'gabriel.coman@superawesome.tv'
  }
  s.source           = {
	:git => 'git@github.com:SuperAwesomeLTD/sa-kws-ios-sdk-objc.git',
	:branch => 'master',
	:tag => "v3.1.4"
  }
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
  s.source_files = 'KWSiOSSDKObjC/Classes/**/*'
  s.dependency 'SAMobileBase', '2.3.12'
  s.resource_bundles = {
      'KWSiOSSDKObjC' => ['KWSiOSSDKObjC/Assets/*.xcassets']
  }

end
