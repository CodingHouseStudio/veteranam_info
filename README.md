<p align="center">
    <a href="https://veteranam.info/"><img id="logo" src='assets/read_me_images/preview.png' width="100%"/></a>
</p>

<p align="center">
        <a href="https://github.com/CodingHouseStudio/veteranam_info/actions/workflows/ci_build_and_test.yaml"><img src="https://img.shields.io/badge/coverage-100%25-E0F179?label=coverage&labelColor=333940&logo=github&color=E0F179" alt="coverage"></a>
        <a href="https://github.com/CodingHouseStudio/veteranam_info"><img src="https://img.shields.io/github/stars/CodingHouseStudio/veteranam_info?style=flat&label=stars&labelColor=333940&color=8957e5&logo=github" alt="github"></a>
      <a href="https://github.com/CodingHouseStudio/veteranam_info/actions/workflows/ci_build_and_test.yaml"><img src="https://img.shields.io/github/actions/workflow/status/CodingHouseStudio/veteranam_info/ci_build_and_test.yaml?branch=main&label=tests&labelColor=333940&logo=github&color=E0F179" alt="tests"></a>
    <a href="https://github.com/CodingHouseStudio/veteranam_info"><img src="https://img.shields.io/github/contributors/CodingHouseStudio/veteranam_info?logo=github&labelColor=333940&color=E0F179" alt="contributors"></a>
    <a href="https://github.com/CodingHouseStudio/veteranam_info/issues"><img src="https://img.shields.io/github/issues/CodingHouseStudio/veteranam_info?style=flat&label=issues&labelColor=333940&color=red&logo=github" alt="issues"></a>
    <a href="https://github.com/CodingHouseStudio/veteranam_info/actions/workflows/ci_build_and_test.yaml"><img src="https://img.shields.io/github/actions/workflow/status/CodingHouseStudio/veteranam_info/ci_build_and_test.yaml?branch=main&label=code analyze and formating&labelColor=333940&logo=github&color=E0F179" alt="code analyze & formating"></a>
    <a href="https://github.com/CodingHouseStudio/veteranam_info/blob/main/LICENSE.md"><img src="https://img.shields.io/badge/license-FSL--1.1--Apache--2.0-blue.svg?logo=github" alt="license"></a>
</p>

<p align="center">
  <a href="https://app.veteranam.info">Web</a> •
  <a href="#">Design</a> •
  <a href="https://apps.apple.com/us/app/veteranam-info/id6584519009">IOS</a> •
  <a href="https://play.google.com/store/apps/details?id=info.veteranam&hl=uk_UA">Android</a> •
  <a href="https://business.veteranam.info">Web-site for business</a> •
  <a href="https://dev-app.veteranam.info">Dev Web-site</a>
</p>

# Veteranam Info

A Flutter no-profit app supporting Ukraine's war veterans.


## Core Features

- 💡 **Multi-Platform**: Works seamlessly across *iOS*, *Android*, and *Web* platforms.
- 🚀 **Comprehensive Testing**: Achieves **100% code coverage**, ensuring minimal errors and robust performance.
- 🧹 **Clean Architecture**: Designed with **clean architecture principles** for scalability and maintainability.


## Preview

<!-- Add preview images/screenshots here -->

## Challenge

The goal was to create an accessible, user-friendly app that centralizes discounts and offers for Ukraine's war veterans. The app needed to prioritize:

- **Ease of use** for veterans.
- **Inclusivity**, ensuring accessibility for users with varying tech skills.
- A **dedicated platform** for businesses to independently manage and add their discount offerings.


## Solution

Using **Flutter**, we developed a cross-platform solution comprising:

1. **Mobile App**: Available for both Android and iOS.
2. **Web Version**: Accessible from any modern web browser supported by Flutter framework
3. **Business Management Platform**: A dedicated interface for businesses to independently add and manage their offers.

The design emphasized **simplicity** and **inclusiveness**, ensuring veterans of varying tech skills could navigate the app with ease.


## Result

- Veterans gained a centralized, easy-to-use platform to access discounts, significantly improving accessibility to benefits.
- Businesses benefited by having a direct, user-friendly way to support veterans, independently manage their offerings, and engage with the veteran community.
- The app strengthened connections between veterans and businesses, fostering support within the community.

## Structure

```yaml
- /lib
# Root directory for the application's source code.

    - /components
    # Directory containing all pages of the application.    
        - /[page_name]
        # Directory structure for an individual page.
            
            - /bloc
            # Contains all BLoC (Business Logic Component) classes for this page (optional).    
            - /view
            # Contains the main widget that initializes and displays this page.    
            - /widget
            # Contains all widgets specific to this page.
                
                - /blocprovider
                # Contains BlocProvider widgets that initialize and provide BLoCs (optional).    
                - /body
                # Contains the main "body" widget for this page, which holds the page's structure and layout.    
            - /field_models
            # Contains models for form fields or page-specific data (optional).    
    - /l10n
    # Contains localization files for supporting multiple languages in the app.    
    - /shared
    # Directory for reusable code, components, and utilities shared across pages.    
        - /bloc
        # Contains reusable or global BLoC classes.    
        - /constants
        # Contains constant values and configurations for styles, themes, and other UI elements.
            - /dimensions
            # Contains dimension constants like padding, margin, etc.
            - /style
            # Contains style constants for the application (e.g., text styles).
            - /text
            # Contains text constants like labels, titles, and descriptions.
            - /theme
            # Contains theme configurations for light and dark modes.
            - /widget
            # Contains reusable widget constants.
            - /widget_keys
            # Contains GlobalKeys for widgets used in tests or UI interaction.    
        - /data_provider
        # Contains classes responsible for fetching or providing data.    
        - /extension
        # Contains Dart extension methods to simplify and enhance code functionality.    
        - /helper
        # Contains helper methods or classes for initializing BLoCs, repositories, and data providers using GetIt.    
        - /models
        # Contains models used throughout the application.
            - /convertors
            # Contains converters for transforming model data into different formats.
            - /failure_model
            # Contains a model for handling failures/errors, including error reporting (e.g., to Sentry or Firebase Crashlytics).
            - /field_models
            # Contains reusable field models.
            - /helper_models
            # Contains models used as dependencies for other models.    
        - /navigation
        # Contains the GoRouter instance or configuration for managing app navigation.    
        - /repositories
        # Contains repository classes that prepare and handle data retrieval for BLoCs, including error handling.    
        - /widget
        # Contains reusable widgets shared across different pages.    
        - shared_dart.dart
        # Contains imports for backend or non-UI related code.    
        - shared_flutter.dart
        # Contains imports for Flutter/UI-related code.    
    - app.dart
    # Main app widget that initializes the entire application.    
    - bootstrap.dart
    # Contains the standard app initialization settings.    
    - firebase_options_development.dart
    # Firebase configuration for the development environment.    
    - firebase_options_production.dart
    # Firebase configuration for the production environment.    
    - main_development.dart
    # Entry point for the development environment.    
    - main_production.dart
    # Entry point for the production environment.

- /test
# Root directory for the application's test cases.

    - /[page_name]
    # Directory for tests related to a specific page.

        - /helpers
        # Contains helper methods for initializing and testing the page.
            - [page_name]_pump_app_helper.dart
            # Contains a method to initialize the page within the test environment.
            - [page_name]_initial_helper.dart
            # Contains a method to initialize the page and verify all widgets without testing functionality.

            - /unit_test
            # Contains unit tests for BLoCs, models, or repositories related to this page. 
            # (If the page has only one unit test, it can be a single file: [page_name]_unit_test.dart).

            - [page_name]_widget_test.dart
            # Contains widget tests for the page. Multiple files can exist for different app flavors.

    - /bloc
    # Contains tests for BLoC classes. May include tests for associated repositories and models.

    - /data_provider
    # Contains tests for data provider classes.

    - /helpers
    # Contains common helper methods and utilities used in tests.
        - change_window_size_helper.dart
        # Contains a method to simulate different screen sizes in tests.
        - scrolling_helper.dart
        # Contains a method to simulate screen scrolling during tests.

        - /widget
        # Contains common widget tests shared across pages.

    - /model
    # Contains tests for model classes (if models are not tested elsewhere).

    - /repository
    # Contains tests for repository classes. May include associated model tests.

    - /test_mocks
    # Contains mock classes and helper methods for testing purposes.
        - go_router_provider_mocks.dart
        # Provides a fake GoRouter class to simulate navigation in tests.
        - mob_build_register.dart
        # Initializes required dependencies for mobile platform tests. 
        # (Without this, tests on mobile platforms will not run).
        - test_repository_mocks.dart
        # Generates mock classes using GenerateNiceMocks for repository tests.
        - user_setting_register.dart
        # Initializes app-specific settings and dependencies for tests. 
        # (Required to ensure smooth test).
```

## Tags

**Technologies & Features:**
- Flutter
- UX & UI Design
- Firebase
- Testing
- Email Template Development
- Mobile App Development
- Web Application
- Analytics
- Application Security
- Clean Architecture
- Brand Identity Design
- Cloudflare
- App Store Upload

## Find Us At:

- <a href="https://www.upwork.com/agencies/codinghouse/">Upwork <img src="https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/upwork-icon.png"  width="16"></a>
- <a href="https://www.linkedin.com/company/coding-house-studio/posts/?feedView=all"> LinkeIn <img src="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png"  width="16"></a>
- <a href="https://www.instagram.com/veteranam_info">Instagram <img src="https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png"  width="16"></a>
- <a href="https://www.facebook.com/brocodev">Facebook <img src="https://i.ibb.co/c8JfWMM/facebook.png" height="16"/></a>

## License

This application is released under the [FSL-1.1-Apache-2.0 License](https://github.com/CodingHouseStudio/veteranam_info/blob/DemianKryk-patch-1/LICENSE.md).

---
---
---
# Information for developments

## Available types of Pull requests:

- feat: A new feature
- fix: A bug fix
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code (white space, formatting, missing semi-colons, etc.)
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing tests or correcting existing tests
- build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- chore: Other changes that don't modify src or test files
- revert: Reverts a previous commit

<!--![coverage][coverage_badge]

Veteranam INFO-->

## Important Commands

fvm flutter pub run build_runner build --delete-conflicting-outputs

for Clean build in case of issues

fvm flutter clean && fvm flutter pub get && fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter clean; fvm flutter pub get; fvm flutter pub run build_runner build --delete-conflicting-outputs

# BEFORE YOU PUSH

fvm flutter clean && fvm flutter pub get && fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm dart format --line-length 80 --set-exit-if-changed lib test integration_test
fvm flutter analyze lib test integration_test
fvm flutter test --coverage

# CREATE NEW BRANCH

git checkout main
git pull
fvm flutter clean && fvm flutter pub get && fvm flutter pub run build_runner build --delete-conflicting-outputs
git checkout -b "branch_name"

# PUSH

git add .
git commit -m "commit name"
git push
git push --set-upstream origin branch_name

# How to merge or rebase from MAIN

# Rebase

1. git fetch --all
2. git pull origin main
3. git rebase main
4. git add .
5. git rebase --continue
6. git push

# Merge

1. git fetch --all
2. git pull origin main
3. git merge main
4. resolve conflicts if any in your IDE
5. git push

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

### Start web version on mobile

+ If you want start web version on mobile, you'll need to run this command in your terminal:
```sh
Prod:
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 -t lib/main_production.dart --flavor production --dart-define=FLAVOUR=production
Dev:
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 -t lib/main_development.dart --flavor development --dart-define=FLAVOUR=development
```
+ To find your computer's IP address, use the following command in your terminal: ipconfig. Look for the first line labeled "IPv4 Address" and note the address.

+ Finally, open a web browser on your mobile device (or emulator) and enter the following URL, replacing *your-ip* with your actual IP address: http://(*your-ip*):8080

**important**: to open the page, the mobile device must be connected to the same Internet network as the computer

### Hide element

When you write code and want to hide an element in the production or development version, you need to call the Config class and select one of its parameters that returns a bool value, for example, if you write Config.isDevelopment, this variable will return true if you start using the development version or false if production.

_\*Veteranam works Web._

---

## Running Tests 🧪

### To run all unit and widget tests use the following command:

```sh
Testing

You need to activate 'very good cli'
(this is done only when running tests for the first time):
dart pub global activate very_good_cli

All unit and widget tests
fvm very_good test

All unit and widget tests use coverage
very_good test --coverage --test-randomize-ordering-seed random
```

+ To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

### Running Integration Tests

+ Chosen device (Windows android tests)

```sh
pre requisite - run chrome web driver in a different terminal window

chromedriver --port=4444

All integration tests on the chosen device which is active
Prod:
fvm flutter test integration_test --flavor production --dart-define=FLAVOUR=production --verbose
Dev:
fvm flutter test integration_test --flavor development --dart-define=FLAVOUR=development --verbose
(If you want more information from tests add prefix -v)
```
+ WEB tests

```sh
run one test:

fvm flutter drive --driver=test_driver/integration_test.dart --target=integration_test/navigation_test.dart -d chrome --web-port=8080 --dart-define=FLAVOUR=development --flavor=development

or
fvm flutter run -d chrome --web-port 4445 integration_test/your_test.dart --dart-define=FLAVOUR=development --flavor=development

run all tests

Get-ChildItem -Path integration_test -Filter '*_test.dart' | ForEach-Object { fvm flutter drive --driver=test_driver/integration_test.dart -d chrome --web-port=8080 --target="$($_.FullName)" } --dart-define=FLAVOUR=development --flavor=development

or

Get-ChildItem -Path integration_test -Filter '*_test.dart' | ForEach-Object { flutter run -d chrome --web-port 8080 $_.FullName } --dart-define=FLAVOUR=development --flavor=development
```
If you want to start test in production mode for tests, change this line -  --dart-define=FLAVOUR=development --flavor=development to this --dart-define=FLAVOUR=production --flavor=production


+ All integration tests on web server headless

```sh
chmod +x integration_tests.sh && ./integration_tests.sh
All integration tests on chrome headless with coverage
chmod +x integration_tests_chrome.sh && ./integration_tests_chrome.sh
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:veteranam/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
    <array>
        <string>en</string>
        <string>es</string>
    </array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```
