import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobSettingsPumpAppHelper({
  required WidgetTester tester,
  required IFeedbackRepository mockFeedbackRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required BuildRepository mockBuildRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerMobFeedbackBloc(
    mockFeedbackRepository: mockFeedbackRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerBuildCubit(mockBuildRepository);
  await tester.pumpApp(
    const MobSettingsScreen(),
    mockGoRouter: mockGoRouter,
    addFeedback: true,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerMobFeedbackBloc({
  required IFeedbackRepository mockFeedbackRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final mobFeedbackBloc = MobFeedbackBloc(
    feedbackRepository: mockFeedbackRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<MobFeedbackBloc>()) {
    GetIt.I.unregister<MobFeedbackBloc>();
  }
  GetIt.I.registerSingleton<MobFeedbackBloc>(
    mobFeedbackBloc,
  );
}

void _registerBuildCubit(
  BuildRepository mockBuildRepository,
) {
  final urlCubit = BuildCubit(
    buildRepository: mockBuildRepository,
  );
  if (GetIt.I.isRegistered<BuildCubit>()) {
    GetIt.I.unregister<BuildCubit>();
  }
  GetIt.I.registerSingleton<BuildCubit>(urlCubit);
}
