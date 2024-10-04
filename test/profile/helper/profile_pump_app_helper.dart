import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> profilePumpAppHelper({
  required WidgetTester tester,
  required AuthenticationRepository mockAuthenticationRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerAuthenticationBloc(mockAuthenticationRepository);

  _registerProfileBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );

  await tester.pumpApp(const ProfileScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.profile.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerAuthenticationBloc(
  AuthenticationRepository mockAuthenticationRepository,
) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}

void _registerProfileBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final profileBloc = ProfileBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<ProfileBloc>()) {
    GetIt.I.unregister<ProfileBloc>();
  }
  GetIt.I.registerSingleton<ProfileBloc>(profileBloc);
}
