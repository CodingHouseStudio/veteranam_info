import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/bloc/app_layout/app_layout_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.authenticationServices} ${KGroupText.cubit}', () {
    late IAppLayoutRepository mockAppLayoutRepository;
    late StreamController<AppVersionEnum> appVersionEnumController;
    setUpAll(() {
      mockAppLayoutRepository = MockIAppLayoutRepository();

      when(mockAppLayoutRepository.appVersionStream).thenAnswer(
        (_) => appVersionEnumController.stream,
      );
      when(mockAppLayoutRepository.getCurrentAppVersion).thenAnswer(
        (_) => AppVersionEnum.mobile,
      );
    });
    setUp(() {
      appVersionEnumController = StreamController.broadcast()
        ..add(AppVersionEnum.mobile);
    });
    blocTest<AppLayoutBloc, AppLayoutState?>(
      'emits [AppLayoutState?] change layout use stream',
      build: () => AppLayoutBloc(
        appLayoutRepository: mockAppLayoutRepository,
      ),
      act: (bloc) {
        appVersionEnumController
          ..add(AppVersionEnum.desk)
          ..add(AppVersionEnum.tablet)
          ..add(AppVersionEnum.mobile)
          ..add(AppVersionEnum.tablet);
      },
      expect: () async => [
        const AppLayoutState.desk(),
        const AppLayoutState.tablet(),
        const AppLayoutState.mob(),
        const AppLayoutState.tablet(),
      ],
    );
    blocTest<AppLayoutBloc, AppLayoutState?>(
      'emits [AppLayoutState?] change layout Error',
      build: () => AppLayoutBloc(
        appLayoutRepository: mockAppLayoutRepository,
      ),
      act: (bloc) {
        appVersionEnumController.addError(KGroupText.failure);
      },
      expect: () async => [
        const AppLayoutState.failure(
          failure: SomeFailure.serverError,
          previousAppVersion: AppVersionEnum.mobile,
        ),
      ],
    );
  });
}
