# AI Usage Disclosure

This project was built with the assistance of AI tools as a productivity accelerator, not as a replacement for engineering judgment or decision-making.

## AI Tools Used
- **ChatGPT** — architecture planning, documentation drafting, refactoring guidance
- **Google Antigravity** — boilerplate generation and inline code suggestions

---

## Where AI Was Used (Files / Modules)

AI assistance was used in the following areas:

- **Feature structure & MVVM scaffolding**
  - `features/products/viewmodels/`
  - `features/products/screens/`
- **Data models**
  - `features/products/models/` (Freezed + JSON serialization)
- **Networking**
  - `core/network/`
  - `features/products/data_sources/product_remote_data_source.dart`
- **Local cache**
  - `features/products/data_sources/product_local_data_source.dart`
- **Repository layer**
  - `features/products/repository/product_repository.dart`
- **Documentation**
  - `README.md`
  - `AI_USAGE.md`

---

## What AI Output Was Accepted

AI-generated output was accepted primarily for:

- Initial Dio request setup
- Basic ViewModel and repository skeletons
- First-draft documentation

These are mechanical tasks where AI provides speed without impacting architectural correctness.

---

## What AI Output Was Modified

Several AI-generated parts were changed after review:

- **Pagination logic**  
  The initial AI draft did not correctly handle the `skip` parameter from the DummyJSON API. I rewrote this logic to ensure proper page offsets and consistent pagination behavior.

- **Error handling**  
  AI initially returned raw Dio errors. I replaced this with a custom `AppException` abstraction so the UI could display clean, user-friendly error states.

- **Repository boundaries**  
  Some AI-generated ViewModels directly accessed API services. I refactored them to go through the repository layer to preserve MVVM separation.

- **Offline behavior**  
  AI initially treated caching as optional. I made caching part of the default data flow so offline support is guaranteed after a successful fetch.

---

## What AI Suggestions Were Rejected (And Why)

Some AI suggestions were intentionally rejected:

### Bloc / Riverpod
AI suggested using Bloc OR Riverpod for state management.  
I rejected this because the scope of this assignment (list, detail, offline cache) does not justify the complexity and boilerplate they introduce.  
I used **Provider + ChangeNotifier**, which fits naturally with MVVM and keeps the codebase readable and easy to reason about.

### Global state containers
AI proposed a single global store.  
I rejected this in favor of **feature-scoped ViewModels**, which keeps concerns isolated and improves testability and maintainability.

### Storage choice (Hive / Isar)
AI suggested Hive or Isar.  
I rejected both in favor of **Sembast**, which I have used successfully in production. It is pure Dart, stable across platforms, and avoids native build issues while being more than fast enough for API caching.

---

## Example of Human Override

AI originally generated a repository that only loaded from the cache when a network error occurred.

I changed this to:
- Load cached data immediately when the app starts
- Fetch fresh data from the network in the background
- Update the cache when new data arrives

This provides a smoother offline-first experience and more closely matches real-world mobile app behavior.

---

## Summary

AI was used to accelerate development, but all architecture, trade-offs, and final implementations were reviewed, modified, and decided by me.  
I can explain and justify every major part of this codebase.
