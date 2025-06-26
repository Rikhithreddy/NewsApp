# NewsApp

Welcome to the NewsApp!

This application is built using **Flutter**, which provides users with the latest news articles from around the world, powered by **NewsAPI**. It offers a seamless and user-friendly experience for reading, saving, and managing articles, with data stored securely using **Firestore**.

---

## Features

### 🔐 User Authentication

#### 🔑 Login Page
- The Login Page allows existing users to securely sign in to the app using either their email and password or their Google account. It serves as the entry point for authenticated users.Implements Firebase Authentication for handling login credentials.On success, the user is redirected to the Home Page.

#### 🆕 Sign Up Page
- The Sign Up Page enables new users to create an account using their email and password.Uses Firebase Authentication to register new users securely.On success, users data is stored securely in Firestore and user is redirected to the Login Page to sign in.


### 🏠 Home Page
- The Home Page fetches and displays news articles from NewsAPI in a scrollable list, updating the content based on the selected category, and allows users to tap on an article to view its full details.

### 🔍 Search Page
- The Search Page allows users to search for news articles by entering keywords, fetches matching results from NewsAPI, displays them in a scrollable list, and shows "No data found" if no relevant articles are found.

### 📄 Article Detail Screen
- The Article Detail Screen displays the full content of a selected news article, including its title, image, author, and description, and allows users to save or remove the article from their saved list.

### 💾 Saved Page
- A dedicated page that lists all articles saved by the user.Displays a "No saved articles" message if no articles are saved.

### 👤 Profile Page
- The Profile Page displays the user's account information, such as name and email, and allows the user to edit their profile details or log out of the app.

### 🧭 Bottom Navigation Bar
- The Bottom Navigation Bar provides quick access to key sections of the app—Home, Search and Saved allowing users to navigate seamlessly between pages.

### ☁️ Firestore Integration
- The app uses Cloud Firestore to store and manage user-specific data, such as saved articles and profile information, ensuring real-time updates and secure, scalable backend storage tied to each authenticated user.

---

## Tech Stack used

- Flutter and Dart: These used to develop the entire frontend of the mobile application, including UI design, navigation, and user interactions.Flutter enables building cross-platform apps for both Android and iOS using a single codebase, which greatly speeds up development and reduces maintenance effort. It offers a rich set of customizable widgets, fast performance through its native compilation, and a responsive, modern UI experience.

- Firebase Authentication: Used to handle user login and registration using email/password and Google Sign-In.It provides a secure, reliable, and easy-to-integrate solution for authenticating users. It manages sessions automatically and works seamlessly with other Firebase services, reducing backend effort.

- Cloud Firestore: Used to store and retrieve user-specific data such as saved articles and profile information.Firestore offers a scalable, real-time NoSQL database that's easy to integrate with Flutter and Firebase Authentication. It supports structured data, offline access, and automatic syncing across devices.

- NewsAPI: Used to fetch up-to-date news articles based on selected categories or search keywords.It provides access to a large variety of reliable global news sources through a simple REST API, making it ideal for building a feature-rich news app without hosting your own news data.

---

## 📱 Screenshots

Below are sample screenshots showcasing different pages and features of the NewsApp:
- [🔐 Login Page](./screenshots/login.jpg)
- [🆕 Sign Up Page](./screenshots/signup.jpg)
- [🏠 Home Page](./screenshots/home.jpg)
- [🔍 Search Page](./screenshots/search.jpg)
- [📄 Article Detail Screen](./screenshots/detail.jpg)
- [💾 Saved Articles Page](./screenshots/saved.jpg)
- [👤 Profile Page](./screenshots/profile.jpg)


---

## 📲 How to Run Locally

Follow the steps below to set up and run the project on your local machine:

### ✅ Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install) (recommended version: Flutter 3.0 or above)
- **Dart SDK**: Comes bundled with Flutter
- **Android Studio / VS Code**: For running and debugging the app
- **Android/iOS Emulator** or a physical device
- **Firebase Project**: Set up Firebase and download `google-services.json` / `GoogleService-Info.plist`
- **NewsAPI Key**: Get a free API key from [https://newsapi.org](https://newsapi.org)

 💡 You can check Flutter setup by running `flutter doctor` in your terminal.


1. **Clone the repository**
   ```bash
   git clone https://github.com/Rikhithreddy/NewsApp.git
   cd NewsApp
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Place your `google-services.json` file in `android/app/` (for Android).
   - Place your `GoogleService-Info.plist` file in `ios/Runner/` (for iOS).

4. **Add your NewsAPI key**
   - Sign up at [https://newsapi.org](https://newsapi.org) to get an API key.
   - Replace the placeholder key in your code (e.g., in `lib/homepage.dart`,`lib/searchpage.dart`):
     ```dart
      String apiKey = 'YOUR_API_KEY';
     ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

### 📖 Usage

Once the app is running, users can:

- Sign up using the email and password to create an account if not registered.
- Log in using email and password or Google Sign-In if already registered.
- Browse news articles by category on the Home Page.
- Search for articles using keywords on the Search Page.
- View full article with title, image, author, and description and to save or delete it.
- View and manage saved articles on the Saved Articles Page.
- Can edit profile details or log out from the Profile Page.
- Navigate between pages using the Bottom Navigation Bar.

---

### 🙋‍♂️ Contributing

Contributions are welcome and appreciated!

If you'd like to contribute to this project, follow these steps:

1. **Fork** the repository  
   Click the "Fork" button at the top right of the repository page.

2. **Clone** your fork locally  
   ```bash
   git clone https://github.com/Rikhithreddy/NewsApp.git
   cd NewsApp
   ```

3. **Create a new branch** for your feature or bug fix  
   ```bash
   git checkout -b feature-name
   ```

4. **Make your changes** and commit them  
   ```bash
   git commit -m "Add: a brief description of your changes"
   ```

5. **Push to your fork**  
   ```bash
   git push origin feature-name
   ```

6. **Open a Pull Request**  
   Go to the original repository and submit a pull request describing your changes.

 💡 Please follow clean code practices and add comments where necessary. Make sure your changes do not break existing functionality.

---

Thank you for checking out **NewsApp**! This project was built with the goal of delivering a smooth and intuitive news reading experience using modern Flutter practices and powerful tools like Firebase and NewsAPI.Feel free to explore the code, suggest improvements, or contribute to make it even better. Happy coding! 🚀