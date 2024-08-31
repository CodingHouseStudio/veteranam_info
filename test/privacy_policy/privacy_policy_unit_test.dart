import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.privacyPolicy} ${KGroupText.cubit}', () {
    late PrivacyPolicyMarkdownCubit privacyPolicyMarkdownCubit;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;

    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (invocation) => KTestText.userSetting,
      );
      privacyPolicyMarkdownCubit = PrivacyPolicyMarkdownCubit(
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<PrivacyPolicyMarkdownCubit, String?>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => privacyPolicyMarkdownCubit,
      act: (bloc) async => bloc.init(),
      expect: () async => [
        predicate<String?>(
          (state) => state != null,
        ),
      ],
    );
  });
}
