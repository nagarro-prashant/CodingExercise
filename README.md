# CodingExercise
**Specifications**
-  Language: *Swift*
-  Design pattern: *Clean-MVVM*
-  Database: *Realm-Swift*
-  Networking framework: *Alamofire*
-  Reactive programming: *RxSwift/Rx-Cocoa*
 
 
**Functional Description:**

**Login Screen:**
- Form contains two text fields: one is Email and other one is Password.
- Email must be a valid email address.
- Password size limitation between 8 - 15 characters.
- `Submit` button to be enabled only in case of email & password are valid otherwise it will be disabled.
- On click of `Submit` button move to next screen without any Remote API Call.
- Cache the login so no need to login every time with option to logout in Posts View.
 
**Posts:**
- This screen have two tabs: **Posts** and **Favorites**.
- The `Posts` tab displays the list of posts from the network.
- The list of posts are available even if the network is not available.
- On clicking a post, will toggle the post either add or remove from favorite.
- `Favorites` tab lists all the posts that have been added to favorites by the user.
- *Swipe to delete* action used to delete the post from favorites.
 
**References for API:**
- Base Url: *https://jsonplaceholder.typicode.com*
- Posts: */posts*
