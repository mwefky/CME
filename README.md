# CMEAssessment

## Overview
CMEAssessment is an iOS app designed to allow users to explore countries and their details, including their name, capital, currency, and flag. The app features a search bar for adding countries, supports location-based default country selection, and integrates persistent storage for offline support.

### This project includes:
- **MainView**: A list of countries that users can manage (add, remove, view details).
- **DetailView**: A detailed view of a selected country.
- **Offline Support**: Cached API responses and saved added countries.
- **Location-Based Default Country**: Adds a default country based on the user’s location or a fallback country (Egypt).

## Features
- **Search Functionality**: Users can search for countries and add them to the main list.
- **Swipe to Delete**: Users can swipe to remove a country from the list.
- **Location Integration**: Automatically adds the first country based on the user's GPS location.
- **Offline Support**: Uses persistent storage to cache data and user-selected countries.
- **Detail View**: Displays the country’s name, capital, currency, and flag.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/CMEAssessment.git
Open the project in Xcode:

bash
Copy code
open CMEAssessment.xcodeproj
Ensure your system has the necessary configurations:

Xcode 14+
iOS 15+
Run the project:

Select a simulator or device and press Cmd + R.
How to Run Tests
Unit Tests
Unit tests are written using XCTest to ensure the app’s core logic functions correctly.

Open Xcode.
Press Cmd + U to run all unit tests.
Unit tests cover:

Country fetching and caching.
Adding, removing, and preventing duplicate countries.
Default country selection based on location or fallback.
UI Tests
UI tests are implemented using XCTest to ensure the UI behaves as expected.

Ensure a simulator is selected.
Press Cmd + U to execute all UI tests.
UI tests cover:

Searching and adding countries.
Swiping and deleting countries.
Navigating to the DetailView.
Verifying UI elements in DetailView.
Architecture
This project follows the MVVM architecture with protocols and dependency injection for separation of concerns.
   ```
## Key Components:

MainViewModel: Handles country data fetching, offline storage, and location-based logic.
CountryService: Fetches country data from the API.
CountryManager: Manages the list of added countries with persistent storage.
LocationManager: Handles location-based default country selection.
DefaultCountryHandler: Encapsulates logic for determining the default country.
   ```
   ```
## Future Enhancements
   ```
Integrate Facebook SnapshotKit for UI Tests
Use SnapshotKit to take screenshots during UI tests for visual regression testing.
Ensure the UI remains consistent across different versions of the app.
Support for Advanced UI Testing
Expand UI tests to cover edge cases, such as large country lists or poor network conditions.
Automate dynamic validations for UI elements like flags and localized country names.
Localization
Add support for multiple languages to make the app more accessible.
Enhanced Offline Support
Include background sync to refresh data while maintaining user changes.
Analytics
Integrate analytics tools (e.g., Firebase) to track user behavior.
Accessibility Improvements
Ensure all UI elements support VoiceOver and dynamic text sizes.
   ```
