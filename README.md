# Test Description: iOS Developer - Timetonic

### Objective:
Create a simple iOS application that includes a login page, and landing page that fetches and displays a list of “books” using Timetonic's public API.
Requirements:

### Login Page:

* Create a login page with fields for email and password.
* Authenticate against Timetonic's public API using the provided
credentials:
* Email: android.developer@timetonic.com
* Password: Android.developer1
* Use those endpoints in order to authenticate:: /createAppkey, /createOauthkey, /createSesskey
* Upon successful authentication, store the session token for later use.
### Landing Page:

* Implement a landing page that displays a list of books associated with the authenticated account.
* Fetch the books from the API using the stored session token and using this endpoint: /getAllBooks
* Display the name and image of each book (filtering out the “contacts books”) in a scrollable list.
The image of each book can be found in the JSON response, inside the object “ownerPrefs” then the value of key “oCoverImg”. This value is used to create the url in this format:
Ex: https://timetonic.com/live/dbi/in/tb/FU-1701419839-65699b3f78400/mo dele-suivi-projet.jpg

### Evaluation Criteria:
* Functionality: Ensure that the application performs the specified tasks correctly.
* Project Organization: Evaluate how well the project is structured and organized.
* Git Management: Assess the use of Git for version control. Include meaningful commit messages.
* Code Readability: Examine the clarity and readability of the code.
* Design Patterns: Assess whether appropriate design patterns are
employed.
* Dependencies: Authorized dependencies are allowed, but fewer
dependencies are preferred.

# Implementation
The application is structured into two distinct sections: the login area and a landing page that displays a list of books. 
The implementation was done using the UIKit framework and following the VIPER architecture. 
This architectural choice aims to provide a structure that allows effective scalability of the application in the future.

### Key Features:

### Sections:
- Login: Integrates a login page with fields for email and password.
- Landing Page: Displays a list of books associated with the authenticated account.
- UIKit Framework:
  - Utilizes UIKit for the development of the user interface, taking advantage of features and components provided by the standard iOS framework.
- VIPER Architecture:
  - The application adopts the VIPER architecture (View, Interactor, Presenter, Entity, Router) for clear and maintainable source code organization.
- Authentication:
 - Implements user authentication through Timetonic endpoints, using /createAppkey, /createOauthkey, and /createSesskey as needed.
- Fetching Books:
  -Retrieves the list of books through the Timetonic endpoint: /getAllBooks, using the session token stored during authentication.

## Login Implementation Details
The login functionality is implemented using the VIPER architecture, providing a clear and modular structure for the authentication process. 
The authentication occurs on Timetonic servers and follows the prescribed protocols of creating appkey, oauthkey, and sesskey.

### Authentication Flow:

- Appkey Creation:
  - The initial step involves creating an appkey through the _/createAppkey_ endpoint. This key is a prerequisite for subsequent authentication steps.
- OAuthKey Generation:
  - Following the appkey creation, the authentication process continues with the generation of an oauthkey via the _/createOauthkey_ endpoint. This key is crucial for user authorization.
- Sesskey Acquisition:
  - The final step involves obtaining a sesskey through the _/createSesskey_ endpoint. This key represents the session token, allowing the application to maintain a user's authenticated state.
- Storage in UserDefaults:
  - The obtained sesskey and a value named o_u (presumably representing the user) are securely stored in UserDefaults. This ensures that the user remains authenticated across application launches.
Usage of Stored Information:

### Subsequent API Requests:
The stored sesskey and o_u value are utilized in subsequent API requests, such as fetching the list of books via the _/getAllBooks_ endpoint. 
This ensures that the user's authentication persists throughout their interaction with the application.

![Log in View](/logInView.png)

## List Books (Landing page)

The landing page is a list of books available to the user, also implemented using the VIPER architecture. Requests are sent to Timetonic servers using the stored sesskey and o_u. 
The response is then formatted into a data model containing the book's name (title) and the URL of the image to be displayed.

![ListBook View](/listBooks.png)
