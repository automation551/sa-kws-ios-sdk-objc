## [3.1.6](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/compare/v3.1.5...v3.1.6) (2019-03-26)


### Bug Fixes

* **Pod:** Updated pod spec ([76b7d9e](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/76b7d9e))

## [3.1.5](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/compare/v3.1.4...v3.1.5) (2019-03-25)


### Bug Fixes

* **Pod:** Fixed pod errors ([13aa11c](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/13aa11c))

## [3.1.4](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/compare/v3.1.3...v3.1.4) (2019-03-25)


### Bug Fixes

* **CI:** Updated CI xcode version to 10.1.0 ([18e9bfb](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/18e9bfb))
* **Podfile:** locked Nimble version ([891cfb6](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/891cfb6))
* **Podspec:** SAMobile version locked at 2.3.12 ([b4b9abf](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/b4b9abf))
* **Project:** Remove Protobufs dependency ([951f900](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/951f900))
* **Project:** Removed Decodable dependency, added conformity to Codable ([afe7c62](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/afe7c62))
* **Project:** update project protocols folder ([6957cff](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/6957cff))
* **Project:** Updated pod file to support Swift 4.2 ([2f0e45c](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/2f0e45c))
* **Project:** updated project file ([fd465a8](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/fd465a8))
* **SAMobileBase:** Updated SAMobileBase version to 2.3.12 ([c3c9f8e](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/c3c9f8e))

## [3.1.3](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc.git/compare/v3.1.2...v3.1.3) (2018-10-29)


### Bug Fixes

* **TargetBlankURLs:** Added logic to handle target blank URLs in webview. ([b2b016c](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc.git/commit/b2b016c))

## [3.1.2](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/compare/v3.1.1...v3.1.2) (2018-07-18)


### Bug Fixes

* **SSFlow:** Updated webview ([ad84ca1](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/ad84ca1))
* **SSOFlow:** Added dismiss button on web view controller ([62d545d](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/62d545d))
* **SSOFlow:** Updated close icon to use systems default one ([b9869f4](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/b9869f4))
* **SSOFlow:** Updated podspec as per new tag versioning. ([493d90b](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/493d90b))

## [3.1.2](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/compare/v3.1.1...v3.1.2) (2018-07-18)


### Bug Fixes

* **SSFlow:** Updated webview ([ad84ca1](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/ad84ca1))
* **SSOFlow:** Updated podspec as per new tag versioning. ([493d90b](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/493d90b))

## [3.1.2](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/compare/v3.1.1...v3.1.2) (2018-07-18)


### Bug Fixes

* **SSFlow:** Updated webview ([ad84ca1](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/ad84ca1))

# 1.0.0 (2018-07-18)


### Bug Fixes

* **CIUpdate:** Updated config to latest version ([0668f1d](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/0668f1d))
* **Config:** Updated config ([cc44073](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/cc44073))
* **SSOFlow:** Update as per PR comments ([713f80a](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/713f80a))
* **SSOFlow:** Updated gitignore ([b969785](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/b969785))
* **SSOFlow:** Updated web view logic - replaced SafariVC with WKWebview. ([6b6e12c](https://github.com/SuperAwesomeLTD/sa-kws-ios-sdk-objc/commit/6b6e12c))

CHANGELOG
=========

3.1.1
 - Cleaned up some code and updated dependencies.

3.1.0
 - Added Utils class to handle authentication token data with ease.
 
3.0.0
 - First major release of the new codebase
 - Merged develop into master
 - Massive clean up of the SDK, refactoring old code and fully relying on the new architecture
 - Added and improved tests

2.4.0
 - Imrpved WebView OAuth flow

2.3.6
 - Updated version string in KWSChildren obj

2.3.5
 - More small tweaks to the WebAuth flow

2.3.4
 - Small tweaks to the authentication through WebView process

2.3.3
 - Added authentication through WebView

2.3.2
 - Updated project dependencies

2.3.1
 - Simplified user auth flow
 - Updated project dependencies


2.2.0
 - Updated Networking, JSON & Utils dependencies to work with the latest versions (and benefit from all subsequent tests & improvements done)
 - Moved some models around into their own folders 

2.1.10
 - Removed the need to explicitly specify the App ID as an integer parameter when setting up the SDK
 - Right now the setup will be done by specifying just the KWS Url, the Client Id and the Client secret, all obtainable from the KWS Dashboard.
 - Refactored the Auth & Create user classes to simplify them. The KWSLoggedUser model, which holds an instance of a logged user (for 24h) and is used internally to get info needed to perform most network operations (that require a logged in user) has been stripped of usless data such as username, parent email, etc. This info can be obtained from the KWSUser model, by calling the appropriate SDK methods.
 - Moved services in related subfolders for better viewability

2.1.9
 - Fixed a warning in KWSRandomName.m; Now when I push to Cocoapods I do so w/o any warnings;

2.1.8
 - Repaired KWSLeader and KWSLeaderboard models to have proper framework / static lib handling headers

2.1.7
 - Added a random name generator method for the KWS SDK
 - Added a fourth paramter to the main "setup" method, which is a App Id (integer); This is needed in order to have random name generator work w/o a logged in user.
