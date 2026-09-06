# MUSEA 🖼️ | ARRT WITHOUT WALLS ~

<p align="center">
  <strong>A digital museum experience where every masterpiece tells a story.</strong>
</p>

MUSEA is a Flutter application that allows users to explore artworks from the Cleveland Museum of Art, view detailed information about each artwork, and build a personal in-session gallery of favorites.

The application combines live API data with a visual identity inspired by classical museums: burgundy wallpaper, antique-gold frames, elegant typography, and museum-style information cards.

---

## ✨ Features

- Fetches a live collection of artworks from an external API.
- Displays a randomly selected **Artwork of the Moment** whenever the gallery is loaded.
- Presents the remaining artworks as a curated, scrollable gallery.
- Opens a dedicated details screen when an artwork is selected.
- Fetches complete artwork details from a second related API endpoint.
- Passes the selected artwork ID from the list screen to the details screen.
- Allows users to bookmark artworks and view them in **My Gallery**.
- Supports adding and removing artworks during the current app session.
- Includes persistent bottom navigation between Discover, Gallery, and About.
- Handles loading, empty, missing-image, and API error states.
- Uses a custom splash experience with an animated logo and an **Enter the Museum** button.
- Applies custom fonts and a consistent museum-inspired color palette.

---

## 🧭 Application Flow

```text
Splash Screen
      ↓
Discover Screen ──→ Artwork Details Screen
      ↓                     ↓
Saved Gallery ←──── Bookmark Artwork
      ↓
About MUSEA
```

---

## 📱 Application Screens

### Splash Screen

The experience begins with the MUSEA logo, a welcoming message, and an **Enter the Museum** button.

The button uses `Navigator.pushReplacement` to open the main application without returning to the splash screen.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/7b3f9bdc-4ef4-48aa-9f3c-f85343e2b31f"
    width="300"
    alt="MUSEA Splash Screen"
  />
</p>

---

### Discover Screen

The Discover screen fetches artwork data from the list API using `FutureBuilder`.

One artwork is highlighted as the **Artwork of the Moment**, while the remaining artworks are displayed in a scrollable curated gallery.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/9ea960ed-f080-4e84-a1d8-47a115c14eb3"
    width="280"
    alt="Artwork of the Moment"
  />
  &nbsp;&nbsp;
  <img
    src="https://github.com/user-attachments/assets/4452c353-fa76-4a1f-a574-2bed55d6f6a9"
    width="280"
    alt="Curated Gallery"
  />
</p>

---

### Artwork Details Screen

When an artwork is selected, its `id` is passed to `ArtworkDetailsScreen`.

The screen calls the details endpoint and displays the artwork image, title, artist, creation date, technique, measurements, department, culture, and description.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/451d40cf-e683-4950-a487-38a4905e4944"
    width="280"
    alt="Artwork Details Screen"
  />
  &nbsp;&nbsp;
  <img
    src="https://github.com/user-attachments/assets/c546878e-0e14-42f3-9f18-1d2ea5d02e68"
    width="280"
    alt="Artwork Information"
  />
</p>

---

### Saved Gallery

The bookmark button lets users add or remove artworks from their personal gallery.

`ValueNotifier` and `ValueListenableBuilder` update the bookmark icon and saved gallery immediately when the saved list changes.

Saved artworks are kept during the current application session.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/582f036e-33e5-4c6d-aa52-f76716e7e7cf"
    width="300"
    alt="MUSEA Saved Gallery"
  />
</p>

---

### About MUSEA

The About screen explains the purpose of the application, its main capabilities, and the source of the artwork collection.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/64d95a3b-4649-4653-9fbf-4165b72f7c32"
    width="280"
    alt="About MUSEA Screen"
  />
  &nbsp;&nbsp;
  <img
    src="https://github.com/user-attachments/assets/1da6b065-07ee-4d04-98cd-5baf7bf15650"
    width="280"
    alt="MUSEA Project Information"
  />
</p>

---

## 🌐 API Integration

MUSEA uses two related endpoints from the [Cleveland Museum of Art Open Access API](https://openaccess-api.clevelandart.org/).

### API 1 - Artwork List

Used to fetch the collection displayed on the Discover screen:

```text
https://openaccess-api.clevelandart.org/api/artworks/?limit=20&has_image=1
```

The response is converted into a list of `ArtworkModel` objects.

### API 2 - Artwork Details

Used to fetch the complete details of the selected artwork:

```text
https://openaccess-api.clevelandart.org/api/artworks/{artworkId}/
```

The selected `artworkId` is passed from `GalleryScreen` to `ArtworkDetailsScreen`, added to the details URL, and converted into an `ArtworkDetailsModel` object.

---

## 🧩 Models

The project uses a separate model for each API response:

- `ArtworkModel`: represents the data required by the artwork list.
- `ArtworkDetailsModel`: represents the complete information shown on the details screen.

Both models include a `fromJson` factory constructor to convert JSON responses into Dart objects.

---

## ⏳ API State Handling

`FutureBuilder` is used on both API-driven screens to handle:

- Loading state with `CircularProgressIndicator`.
- Successful data display.
- Empty responses.
- Network or API errors with user-friendly messages.
- Missing or broken artwork images with fallback icons.

---

## ⭐ Extra Credit

The following features were implemented beyond the minimum project requirements:

- **Artwork of the Moment:** the collection is shuffled and a different artwork is featured whenever the gallery is loaded.
- **Saved Gallery:** users can bookmark and remove favorite artworks during the current app session.
- **Reactive Favorites:** `ValueNotifier` and `ValueListenableBuilder` immediately update the bookmark icon and saved gallery.
- **Persistent Navigation Layout:** `IndexedStack` preserves the state of the Discover, Gallery, and About tabs.
- **Custom Splash Experience:** animated logo entrance, welcoming message, and a controlled museum-entry button.
- **Custom Museum Identity:** antique-gold artwork frames, burgundy wallpaper, custom logo, typography, shadows, and a cohesive color palette.
- **Robust API Experience:** loading, empty, error, and broken-image states are handled gracefully.

---

## 🛠️ Flutter Concepts and Widgets

The project demonstrates:

- `Scaffold`
- `AppBar`
- `FutureBuilder`
- `ListView`
- `GridView.builder`
- `ValueNotifier`
- `ValueListenableBuilder`
- `IndexedStack`
- `BottomNavigationBar`
- `Navigator`
- `MaterialPageRoute`
- `GestureDetector`
- `ElevatedButton`
- `Image.network`
- `Image.asset`
- `Stack`
- `Column`
- `Row`
- `Expanded`
- `Container`
- `MediaQuery`
- `TweenAnimationBuilder`

---

## 📦 Packages

- [`http`](https://pub.dev/packages/http) - sends requests to the artwork APIs.
- [`google_fonts`](https://pub.dev/packages/google_fonts) - provides the Cinzel and Cormorant Garamond fonts.

---

## 📂 Project Structure

```text
lib/
├── data/
│   └── saved_artworks.dart
├── models/
│   ├── artwork_model.dart
│   └── artwork_details_model.dart
├── screens/
│   ├── splash_screen.dart
│   ├── main_navigation_screen.dart
│   ├── gallery_screen.dart
│   ├── artwork_details_screen.dart
│   ├── saved_gallery_screen.dart
│   └── about_screen.dart
├── services/
│   └── api.dart
└── main.dart

assets/
└── images/
    ├── musea_logo.png
    └── musea_wallpaper.png
```



---

## 👩🏻‍💻 Developer

Designed and developed by **Fulwah** as an individual Flutter Bootcamp Project 2.
