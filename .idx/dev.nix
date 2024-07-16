# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"

  # Sets environment variables in the workspace
  env = {
    # Set the environment variable for the build flavor
    BUILD_FLAVOR = "production"; # or "development"
  };
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodePackages.firebase-tools
    pkgs.jdk17
    pkgs.unzip
    pkgs.chromedriver
  ];

  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
      "dart-code.dart-code"
      "dart-code.flutter"
      "felixangelov.bloc"
      "localizely.flutter-intl"
      "flutterando.flutter-coverage"
    ];

    # Enable previews
    previews = {
      enable = true;
      previews = {
        web = {
          # Use the environment variable in the command
          command = ["flutter" "run" "--flavor" "$BUILD_FLAVOR" "-t" "lib/main_$BUILD_FLAVOR.dart" "-dart--define" "FLAVOUR=$BUILD_FLAVOR" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT"];
          manager = "flutter";
        };
        android = {
          # Use the environment variable in the command
          command = ["flutter" "run" "--flavor" "$BUILD_FLAVOR" "-t" "lib/main_$BUILD_FLAVOR.dart" "-dart--define" "FLAVOUR=$BUILD_FLAVOR" "--machine" "-d" "android" "-d" "localhost:5555" ];
          manager = "flutter";
        };
      };
    };

# Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
                flutterSetup = ''
          cd /home/user/myapp/android
          flutter pub get
          flutter pub run build_runner build --delete-conflicting-outputs
          '';
                build-flutter = ''
          cd /home/user/veteran/android
          ./gradlew \
            --parallel
 \
            -Pverbose=true \
            -Ptarget-platform=android-x86 \
            -Ptarget=/home/user/veteran/lib/main_$BUILD_FLAVOR.dart \
            -Pbase-application-name=info.veteranam \
            -Pdart-defines=FLAVOUR=$BUILD_FLAVOR \
            -Pdart-obfuscation=false \
            -Ptrack-widget-creation=true \
            -Ptree-shake-icons=false \
            -Pfilesystem-scheme=org-dartlang-root \
            assembleDebug
          # TODO: Execute web build in debug mode using $BUILD_FLAVOR.
          # flutter run does this transparently either way
          # https://github.com/flutter/flutter/issues/96283#issuecomment-1144750411
          flutter build web --debug -t lib/main_$BUILD_FLAVOR.dart --flavor $BUILD_FLAVOR --dart-define=FLAVOUR=$BUILD_FLAVOR 
          adb -s localhost:5555 wait-for-device
        '';
      };
      # # Runs when the workspace is (re)started
      # onStart = {
      #   # Example: start a background task to watch and re-build backend code
      #    flutterSetup = "flutter pub run build_runner watch --delete-conflicting-outputs";
      # };
    };
  };
}
