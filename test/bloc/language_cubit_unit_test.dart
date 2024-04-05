import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group(KScreenBlocName.languageCubit, () {
    late LanguageCubit languageCubit;
    setUp(() => languageCubit = LanguageCubit());
    blocTest<LanguageCubit, Language?>(
      'emits [Language.ukrain] when init language',
      build: () => languageCubit,
      act: (cubit) async {
        await cubit.initLanguage();
      },
      expect: () async => [
        Language.ukrain,
      ],
    );
    blocTest<LanguageCubit, Language?>(
      'emits [Language.english] change language use english index',
      build: () => languageCubit,
      act: (cubit) async {
        await cubit.changeLanguage(KTestConstants.englishIndex);
      },
      expect: () async => [
        Language.english,
      ],
    );
    blocTest<LanguageCubit, Language?>(
      'emits [Language.ukrain, Language.ukrain] changes language',
      build: () => languageCubit,
      act: (cubit) async {
        await cubit.changeLanguage(KTestConstants.ukrainIndex);
        await cubit.changeLanguage(KTestConstants.englishIndex);
      },
      expect: () async => [
        Language.ukrain,
        Language.english,
      ],
    );
  });
}
