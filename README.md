# itunes-search-api
An iOS app that retrieves data from iTunes API and can be viewed on a list. And save the one the you like. It can also play a trailer on the
selected track.

#API
The API that was used for this app is  https://itunes.apple.com/search?term=star&country=au&amp;media=movie&all
and in the app code you can select either use the downloaded file or just use the external API.

#Data Persist
Uses Realm for saving data from the API, and uses User Defaults for saving the date for showing the user when was the app was last used.

#Architecture
Used MVC and Delegation and Protocol for sending data around the app. I use MVC because it was Apple's preferred way of architecting iOS apps.
