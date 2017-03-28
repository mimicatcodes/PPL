# People and the City - Spotify Code Challenge

![people and the city](https://cloud.githubusercontent.com/assets/19986066/24328443/b4e991f0-11b7-11e7-9a81-e27b8207b4e0.png)

<strong>People and the City</strong> is an interactive iOS app that makes various HTTP requests to the server called PPL. Using this app, you can add different people with their name and favorite city information. This app is designed to provide an admin of the server an option to manage the database easily and efficiently on a mobile platform. As an admin, you can do anything you want - add a person object with attributes of name and favorite city, edit the information and even delete it. Every action you make on this app will immediately be reflected to the server. 

To use or test the application, please do the following:

Open the file, PeopleAndTheCity.xcworkspace using Xcode, and run the project.

When the app launches, you will see an empty screen as there is no person object added on the server yet. Please tap ‘+’ button to add your (or anyone’s) name and favorite city and press submit. As the screen dismisses, you will see a new person added to the server and displayed on the table view cell!

To edit the person’s information, swipe left on the cell. Tap Edit, confirm the existing information, make changes accordingly and press save. The person object now has updated information of either name or favorite city or both!

To delete a person and its data, swipe left on the cell. Tap Delete and you will see an alert pop up. If you wish to proceed, press Delete, otherwise Cancel. If you chose to delete the person’s data, it will be reflected in your table view and will no longer exist. 

Below is the information that I included in the body of the email I sent to TTP upon the challenge submission. The client is able to do the following in order as required in the code challenge:

* **Make a GET request to /people** -> Upon launching the app, it will make a GET request to /people, retrieve data and display it on the table view. Currently it’s empty as there is no one added into the database yet.

* **Make a POST request to /people** -> Tap ‘+’ and add a new person with name Sean and favorite city New York. This action will make a POST request to /people and create the person object with the following attributes: : id, name : “Sean”, favoriteCity : “New York" 

* **Make a GET request to retrieve the object created in the previous request** -> Upon dismissing the Add screen, you will see a new person object added onto the table view.

* **Make a PUT request to /people/1 and modify the attribute city to be “Brooklyn”** -> Swipe left on the Sean cell in the table view. Tap Edit, review the existing information, make changes accordingly and press save.

* **Make a GET request to /people/1** -> The person object now has updated information of either name or favorite city or both.

* **Make a DELETE request to /people/1** -> Swipe left on the cell in the table view. Tap Delete and you will see an alert pop up. If you wish to proceed, press Delete, otherwise Cancel. If you chose to delete the person’s data, it will be reflected in your table view and will no longer exist

## Server
People and the City uses the <strong>PPL Server</strong> that I've built with Vapor, PostgreSQL and Skeleton. For more information about the server, please visit this link: http://bit.ly/PPLServer


