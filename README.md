<h1>NewsApp</h1>

<p>Welcome to the NewsApp! This application is built using Flutter which provides users with the latest news articles from around the world, powered by NewsAPI. It offers a seamless and user-friendly experience for reading, saving, and managing articles, with data stored securely using Firestore.<p>

<h2>Features</h2>
<ul>
  <li>User Authentication
    <ul>
      <li>Login: Users can log in using their email ID and password or sign in with Google.</li>
      <li>Sign Up: New users can create an account if they do not have one.</li>
    </ul>
  </li>
  <li>Home Page
    <ul>
      <li>Displays articles relevant to the selected category fetched from NewsAPI.</li>
    </ul>
  </li>
  <li>Search Page
    <ul>
      <li>A search bar allows users to search for relevant articles.</li>
      <li>Displays a "No Data Found" message when no matching articles are found.</li>
    </ul>
  </li>
  <li>Article Detail Screen
    <ul>
      <li>Shows detailed information about the selected article.</li>
      <li>Users can save or delete articles from this screen.</li>
    </ul>
  </li>
  <li>Saved Page
    <ul>
      <li>A dedicated page that lists all articles saved by the user.</li>
      <li>Displays a "No saved articles" message if no articles are saved.</li>
    </ul>
  </li>
  <li>Profile Page
    <ul>
      <li>Displays user information.</li>
      <li>Includes options to edit profile details and log out.</li>
    </ul>
  </li>
  <li>Bottom Navigation Bar
    <ul>
      <li>Located at the bottom of the home page, allowing easy navigation between the Home, Search, and Saved pages.</li>
    </ul>
  </li>
  <li>Firestore Integration
    <ul>
      <li>All data is stored and manipulated in Firestore, ensuring cloud-based persistence and synchronization across devices.</li>
    </ul>
  </li>
</ul>

<h2>Follow these steps to run the app locally on your machine</h2>
<ul>
  <li>Prerequisites
    <ul>
      <li>Flutter SDK (latest stable version)</li>
      <li>Dart SDK</li>
      <li>Android Studio or Visual Studio Code (with Flutter extension)</li>
    </ul>
  </li>
  <li>Installation
    <ul>
      <li>Clone the repository
        <ul>
          <li>git clone https://github.com/Rikhithreddy/NewsApp</li>
          <li>cd NewsApp</li>
        </ul>
      </li> 
      <li>Install dependencies
        <ul>
          <li>flutter pub get</li>
        </ul>
      </li>
      <li>Running the App
        <ul>
          <li>Connect a device or start an emulator.</li>
        </ul>
      </li>
      <li>Run the app
        <ul>
          <li>flutter run</li>
        </ul>
      </li>
    </ul>
  </li>
  <li>Usage
    <ul>
      <li>Launch the app and log in using your credentials or Google,signup if there was no account.</li>
      <li>Browse articles on the home page and use the search bar in serach page for specific topics.</li>
      <li>Tap an article to view its details and save or delete it as needed.</li>
      <li>Visit the Saved Articles page to access saved items.</li>
      <li>Update your profile information or log out from the profile page.</li>
    </ul>
  </li>
</ul>
<h2>Tech Stack used</h2>
<ul>
  <li>NewsAPI: For providing news data.</li>
  <li>Flutter and Dart: For their powerful cross-platform development capabilities.</li>
  <li>Firebase: For backend services.</li>
</ul>

Enjoy using the NewsApp!
