# People and the City - Spotify Code Challenge

![people and the city](https://cloud.githubusercontent.com/assets/19986066/24328443/b4e991f0-11b7-11e7-9a81-e27b8207b4e0.png)

<strong>People and the City</strong>, an interactive iOS app that makes various HTTP requests to the server called PPL. Using this app, you can add different people with their name and favorite city information. This app is designed to provide an admin of the server an option to manage the database easily and efficiently on a mobile platform. As an admin, you can do anything you want - add a person object with attributes of name and favorite city, edit the information and even delete it. Every action you make on this app will immediately be reflected to the server. 

To use or test the application, please do the following:

Open the file, PeopleAndTheCity.xcworkspace using Xcode, and run the project.

When the app launches, you will see an empty screen as there is no person object added on the server yet. Please tap ‘+’ button to add your (or anyone’s) name and favorite city and press submit. As the screen dismisses, you will see a new person added to the server and displayed on the table view cell!

To edit the person’s information, swipe left on the cell. Tap Edit, confirm the existing information, make changes accordingly and press save. The person object now has updated information of either name or favorite city or both!

To delete a person and its data, swipe left on the cell. Tap Delete and you will see an alert pop up. If you wish to proceed, press Delete, otherwise Cancel. If you chose to delete the person’s data, it will be reflected in your table view and will no longer exist. 

## Server
People and the City uses the <strong>PPL Server</strong> that I've built with Vapor, PostgreSQL and Skeleton. For more information about the server, please visit this link: http://bit.ly/PPLServer



