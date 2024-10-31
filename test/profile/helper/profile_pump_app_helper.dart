import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/profile/bloc/profile_bloc.dart';
import 'package:veteranam/components/profile/view/profile_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> profilePumpAppHelper({
  required WidgetTester tester,
  required AuthenticationRepository mockAuthenticationRepository,
  required IDataPickerRepository mockDataPickerRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerAuthenticationBloc(mockAuthenticationRepository);

  _registerProfileBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
    mockDataPickerRepository: mockDataPickerRepository,
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
  required IDataPickerRepository mockDataPickerRepository,
}) {
  final profileBloc = ProfileBloc(
    authenticationRepository: mockAuthenticationRepository,
    dataPickerRepository: mockDataPickerRepository,
  );
  if (GetIt.I.isRegistered<ProfileBloc>()) {
    GetIt.I.unregister<ProfileBloc>();
  }
  GetIt.I.registerSingleton<ProfileBloc>(profileBloc);
}
