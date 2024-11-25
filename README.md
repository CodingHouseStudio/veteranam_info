TO BE CHANGED SOON

# Veteranam

Available types of Pull requests:

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

![coverage][coverage_badge]


[![License: MIT][license_badge]][license_link]

Veteranam INFO

---

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

