import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/mob_settings/view/mob_settings_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> mobSettingsPumpAppHelper({
  required WidgetTester tester,
  required IFeedbackRepository mockFeedbackRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required UserRepository mockUserRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerMobFeedbackBloc(
    mockFeedbackRepository: mockFeedbackRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerUserWatcherBloc(
    mockUserRepository: mockUserRepository,
  );
  await tester.pumpApp(
    const MobSettingsScreen(),
    mockGoRouter: mockGoRouter,
    addFeedback: true,
  );

  expect(
    find.byKey(MobSettingsKeys.screen),
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

void _registerUserWatcherBloc({
  required UserRepository mockUserRepository,
}) {
  final userWatcherBloc = UserWatcherBloc(
    userRepository: mockUserRepository,
  );
  if (GetIt.I.isRegistered<UserWatcherBloc>()) {
    GetIt.I.unregister<UserWatcherBloc>();
  }
  GetIt.I.registerSingleton<UserWatcherBloc>(userWatcherBloc);
}
