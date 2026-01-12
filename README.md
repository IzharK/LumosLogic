# Flutter Product Catalog

A production-grade Flutter application demonstrating MVVM architecture, offline support, and clean code practices.

## Features

- **Product List**: Paginated scrolling from DummyJSON API.
- **Product Details**: Detailed view of products.
- **Offline First**: Caches data using Sembast.
  - "Network First" strategy for fresh data.
  - Falls back to local cache on network error.
- **MVVM Architecture**: Clear separation of concerns.
- **Dependency Injection**: Using `get_it`.
- **State Management**: Using `provider`.

## Architecture

The project follows a strict MVVM pattern:

`UI` -> `ViewModel` -> `Repository` -> `Data Sources` (Remote & Local)

### Folder Structure
```
lib/
  core/         # Core utilities (Network, Error, DI, DB)
  features/
    products/   # Product Feature
      models/       # Freezed Models
      data_sources/ # Remote (Dio) & Local (Sembast)
      repository/   # Data coordination
      viewmodels/   # State management (ChangeNotifier)
      screens/      # Widgets
```

## Decisions & Trade-offs

### Local Storage: Sembast
I chose **Sembast** over Hive/Isar because:
1.  **Reliability**: Sembast is pure Dart and extremely stable across all platforms without native dependencies.
2.  **Support**: Hive 3.x has had long beta periods, and Isar can sometimes have complex build setup issues. Sembast offers an excellent balance of performance and simplicity for this use case.
3.  **Experience**: I have extensive positive experience with Sembast in production apps.

### State Management: Provider
Chosen for its simplicity and explicit requirement. It pairs perfectly with `ChangeNotifier` for per-screen ViewModels.

## Setup

1.  Clone the repo.
2.  Run `flutter pub get`.
3.  Run code generation:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  Run `flutter run`.

## Libraries Used
- `dio`: Networking
- `provider`: State Management
- `get_it`: Service Locator
- `freezed`: Immutable Data Classes
- `sembast`: NoSQL Database (Offline Cache)
- `cached_network_image`: Image caching
- `json_serializable`: JSON parsing
