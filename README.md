# 📱 WatchWise

## 📝 Description
Watch Wise is a movie discovery app that helps users explore films, track favorites, and get personalized recommendations based on their preferences. The app provides a seamless user experience with features like search, genre filtering, watchlists, and trending movies, making it easy to find the perfect movie for any mood. Its goal is to make movie selection smarter and more enjoyable.

## 🚀 Features
🔍 Search Movies by title with real-time results
🌟 Trending & Top-Rated Movies section
❤️ Favorite List to save movies for later
🎯 Personalized Recommendations based on your favorites
🗂️ Genre Filtering for easier discovery
🔐 User Authentication (Sign up & Login)
📱 Responsive UI with smooth navigation
📂 Local Storage of user preferences using Hive
📄 Detailed Movie Info including poster, title, year, and more

## 🧰 Tech Stack
- Flutter – Cross-platform framework for building beautiful UIs
- Hive – Lightweight and fast local NoSQL database for storing user data
- HTTP – For making RESTful API requests to fetch movie data
- OMDb API / TMDB API – Used to retrieve movie details, ratings, and posters
- Custom Theming – Using AppColor for consistent color scheme
- Bottom Navigation Bar – For smooth navigation across screens



## 🛠️ Installation / Setup
###Clone the repository
```bash
git clone https://github.com/your-username/movies_app.git
cd movies_app

###Install dependencies
```bash
flutter pub get

###Set up Hive for local storage
```bash
flutter packages pub run build_runner build

###Run the app
```bash
flutter run
