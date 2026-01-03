import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/markdown_file_dialog/bloc/markdown_file_cubit.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.privacyPolicy} ${KGroupText.cubit}', () {
    late MarkdownFileCubit privacyPolicyMarkdownCubit;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;

    setUp(() {
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      when(mockAppAuthenticationRepository.currentUserSetting).thenAnswer(
        (invocation) => KTestVariables.userSetting,
      );
      privacyPolicyMarkdownCubit = MarkdownFileCubit(
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<MarkdownFileCubit, String?>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => privacyPolicyMarkdownCubit,
      act: (bloc) async => bloc.init(
        ukFilePath: KAppText.ukPrivacyPolicyPath,
        enFilePath: KAppText.enPrivacyPolicyPath,
      ),
      expect: () async => [
        predicate<String?>(
          (state) => state != null,
        ),
      ],
    );
  });
}
