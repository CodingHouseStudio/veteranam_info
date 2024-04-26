// import 'dart:async';
// import 'dart:ui';

// import 'package:bloc/bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:kozak/shared/shared.dart';

// /// COMMENT: Cubit changes and sets localization in App
// @Singleton()
// class LanguageCubit extends Cubit<Language> {
//   LanguageCubit({required AuthenticationRepository authenticationRepository})
//       : _authenticationRepository = authenticationRepository,
//         super(
//           authenticationRepository.currentUserSetting.locale,
//         );
//   final AuthenticationRepository _authenticationRepository;
//   late StreamSubscription<UserSetting> authenticationStatusSubscription;

//   Future<void> changeLanguage(String language) async {
//     if (_authenticationRepository.currentUser.isNotEmpty) {
//       final userSetting = _authenticationRepository.currentUserSetting;
//       await _authenticationRepository.updateUserSetting(
//         userSetting: userSetting.copyWith(locale: language.getLocale),
//       );
//     }
//     _updateLocale(language.getLocale);
//   }

//   void _updateLocale(Language language) {
//     emit(language);
//   }

//   Future<void> initLanguage() async {
//     authenticationStatusSubscription = _authenticationRepository
//         .userSettingStream
//         .listen((userSetting) => _updateLocale(userSetting.locale));
//   }

//   @override
//   Future<void> close() {
//     authenticationStatusSubscription.cancel();
//     _authenticationRepository.dispose();
//     return super.close();
//   }
// }

// enum Language {
//   ukrain(
//     Locale('uk', 'UK'),
//     // Assets.indonesia,
//     'UA',
//   ),
//   english(
//     Locale('en', 'US'),
//     // Assets.english,
//     'EN',
//   );

//   /// Add another languages support here
//   const Language(this.value, this.text);

//   final Locale value;
//   // final AssetGenImage
//   //     image; // Optional: this properties used for ListTile details
//   final String text; // Optional: this properties used for ListTile details
// }

// extension LanguageExtension on Language {
//   static List<Language> get getAllLanguage {
//     return Language.values.map((lang) => lang).toList();
//   }
// }

// extension GetLanguage on String {
//   Language get getLocale {
//     switch (this) {
//       case 'UA':
//         return Language.ukrain;
//       case 'EN':
//         return Language.english;
//       default:
//         return Language.ukrain;
//     }
//   }
// }
