
# itunes-search-api
An iOS app that retrieves data from iTunes API and can be viewed on a list. And save the one the you like. It can also play a trailer on the
selected track.

## API ##
The API that was used for this app is  https://itunes.apple.com/search?term=star&country=au&amp;media=movie&all
and in the app code you can select either use the downloaded file or just use the external API.

## Data Persist ##
Uses Realm for saving data from the API, and uses User Defaults for saving the date for showing the user when was the app was last used.

## Architecture ##
Used MVC and Delegation and Protocol for sending data around the app. I use MVC because it was Apple's preferred way of architecting iOS apps.

![Simulator Screen Shot - iPhone 12 Pro - 2021-05-21 at 14 34 49](https://user-images.githubusercontent.com/33449251/119094707-f3281e80-ba43-11eb-807e-418a1a5a5167.png) | ![Simulator Screen Shot - iPhone 12 Pro - 2021-05-21 at 14 34 59](https://user-images.githubusercontent.com/33449251/119094747-ff13e080-ba43-11eb-98ed-1eca07b1e9ea.png) |
![Simulator Screen Shot - iPhone 12 Pro - 2021-05-21 at 14 35 06](https://user-images.githubusercontent.com/33449251/119094754-00dda400-ba44-11eb-9bbf-ac6372cfd0fb.png) |
![Uploading Simulator Screen Shot - iPhone 12 Pro - 2021-05-21 at 14.38.47.png…]()
