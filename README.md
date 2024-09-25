# CodingExercise
**Specifications**
- Language Swift.
-  Design pattern: MVVM
-  Realm-Swift for DB.
- Alamofire for network calls.
- RxSwift/Rx-Cocoa for reactive programming.
 
 
***Functional Description:***

Login Screen
- Form contains two text fields: one is email and other one is password
- Email must be valid email address
- Password size limitation between 8 - 15 characters
- Submit button to be enabled only in case of email & password are valid otherwise it will be disabled
- On click of Submit button move to next screen without any Remote API Call.
- Cache the login so no need to login every time with option to logout in Posts View.
 
Screen2:
This screen should have two tabs (Post and Favorites).
The posts tab should have the following behavior:
The posts tab will display a list of posts from the network.
The list of posts should be available even if the network is not available.
On clicking a post, will toggle the post either add or remove from favorite
The favorites tab should have the following behavior:
Favorite tabs will list all the posts that have been added to favorites by the user.
Add action to delete the post from favorite “preferred swipe to delete”
 
References for API:
Base Url: https://jsonplaceholder.typicode.com
Posts: /posts
