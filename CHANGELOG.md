CHANGELOG
=========

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
