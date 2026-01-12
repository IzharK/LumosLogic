# Flutter Product Catalog

A production-grade Flutter application demonstrating MVVM architecture, offline support, and clean code practices.

## Features

* **Product List**: Paginated scrolling from DummyJSON API.
* **Product Details**: Detailed view of products.
* **Offline First**: Caches data using Sembast.

  * "Network First" strategy for fresh data.
  * Falls back to local cache on network error.
* **MVVM Architecture**: Clear separation of concerns.
* **Dependency Injection**: Using `get_it`.
* **State Management**: Using `provider`.

## Architecture Overview

The project follows a strict MVVM pattern:

`UI (Screens)` → `ViewModels (ChangeNotifier)` → `Repository` → `Data Sources (Remote & Local)`

This ensures that:

* UI contains no business or data logic
* ViewModels manage state and user actions
* Repositories coordinate data from API and local cache
* Data sources are responsible only for network and database access

### Folder Structure

```
lib/
  core/         # Core utilities (Network, Error handling, DI, Database)
  features/
    products/   # Product Feature
      models/       # Freezed data models
      data_sources/ # Remote (Dio) & Local (Sembast)
      repository/   # Data coordination and caching logic
      viewmodels/   # Screen-level state (ChangeNotifier)
      screens/      # Flutter UI widgets
```

## Key Decisions & Trade-offs

### Local Storage — Sembast

I chose **Sembast** over Hive or Isar for the following reasons:

1. **Reliability** — Sembast is pure Dart with no native bindings, making it stable across Android, iOS, and desktop.
2. **Build Simplicity** — Hive 3.x and Isar often introduce build and codegen issues; Sembast avoids these completely.
3. **Performance Fit** — For caching paginated API data, Sembast provides more than enough performance.

### State Management — Provider

Provider with `ChangeNotifier` was chosen because:

* It fits naturally with MVVM
* It avoids unnecessary boilerplate
* It is easy to debug and reason about for this project’s scope

More complex patterns such as Bloc or Riverpod were intentionally avoided to keep the architecture clear and maintainable.

### Offline Strategy

The app uses a **Network First, Cache Fallback** approach:

* API is called whenever possible
* Successful responses are saved to local storage
* If the API fails, cached data is shown automatically

This provides a realistic offline-first experience without unnecessary sync complexity.

## Setup Instructions

1. Clone the repository.
2. Install dependencies:

   ```bash
   flutter pub get
   ```
3. Run code generation:

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Run the app:

   ```bash
   flutter run
   ```

## Known Limitations

* The cache stores only the last successfully fetched pages; it does not implement advanced cache invalidation.
* No background refresh or sync scheduling is implemented.
* UI is intentionally simple to focus on architecture and data flow.
* The app does not support filtering or searching.

## Screen Recording

A short screen recording demonstrating the following flows is included in the `/screenshots` folder:

* App launch with cached data
* Loading state while fetching from network
* Product list pagination
* Product detail view
* Error handling when network is unavailable

https://github.com/user-attachments/assets/98806a06-31d8-43ef-9e64-078455e5e5f3

The recording shows how the app behaves both online and offline to demonstrate the offline-first design.


Please refer to the screenshots to see the list view, detail view, loading states, and offline behavior.

## Libraries Used

* `dio` — Networking
* `provider` — State management
* `get_it` — Dependency injection
* `freezed` — Immutable data models
* `json_serializable` — JSON parsing
* `sembast` — Offline cache
* `cached_network_image` — Image caching
