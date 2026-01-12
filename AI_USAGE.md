# AI Usage Disclosure

This project was built with the assistance of AI tools as a productivity aid, not as a replacement for engineering judgment.

## AI Tools Used
- ChatGPT (architecture planning, documentation drafting, refactoring)
- Cursor IDE (boilerplate generation and code suggestions)

---

## Where AI Was Used

AI was used in the following areas:

- Generating initial folder structure for Clean Architecture
- Creating Freezed data models for API responses
- Writing the first draft of Dio API service
- Drafting repository skeletons
- Writing README.md and this AI_USAGE.md

---

## What AI Output Was Accepted

I accepted AI-generated output when it:
- Created repetitive boilerplate (Freezed models, JSON serialization)
- Generated basic repository and data source interfaces
- Scaffolded Flutter widget layouts
- Drafted documentation text that I then refined

These outputs helped reduce time spent on mechanical coding.

---

## What AI Output Was Modified

Several AI-generated parts were changed after review:

- Pagination logic was incorrect in the first AI draft; it did not account for the `skip` parameter properly, so I rewrote the paging logic.
- Error handling was initially too generic; I replaced it with a custom `AppException` hierarchy for better UI feedback.
- The repository layer originally mixed caching and networking; I separated them into clean data sources to follow Clean Architecture.
- ViewModels initially contained API calls directly; I refactored them to call UseCases instead.

---

## What AI Suggestions Were Rejected (And Why)

Some AI suggestions were intentionally rejected:

- **Bloc / Riverpod**:  
  AI suggested using Riverpod for state management.  
  I rejected this because the project scope is intentionally small (list + detail + cache). Using Bloc/Riverpod would add unnecessary boilerplate and cognitive load.  
  I chose **Provider + ChangeNotifier** to keep the architecture clean, readable, and aligned with the assignment’s “not a UI-heavy challenge” focus.

- **Global state management**:  
  AI proposed using a global state container. I rejected this in favor of feature-scoped ViewModels to keep the architecture modular.

- **Choice of persistent storage solution**:  
  AI initially proposed using Hive or Isar. I rejected this in favor of a little known but powerful Sembast as I have excellent experience with it. Also, the support for both Hive and Isar is really poor, whereas Sembast is regularly updated.

---

## Example of Human Override

One concrete example:

AI originally generated a repository that always fetched from the network and only fell back to cache if an exception occurred.

I changed this to:
- Always save the last successful API response
- Load from cache first when the app launches
- Use network only to refresh data

This made the offline experience smoother and better aligned with real-world offline-first design.

---

## Summary

AI was used as a productivity accelerator, but all architectural decisions, trade-offs, and final implementations were reviewed, modified, and approved by me.  
I can explain and justify every major part of this codebase.
