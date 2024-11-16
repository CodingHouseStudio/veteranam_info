import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/profile/bloc/profile_bloc.dart';
import 'package:veteranam/components/profile/view/profile_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> profilePumpAppHelper({
  required WidgetTester tester,
  required UserRepository mockUserRepository,
  required IDataPickerRepository mockDataPickerRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerUserWatcherBloc(mockUserRepository);

  _registerProfileBloc(
    mockUserRepository: mockUserRepository,
    mockDataPickerRepository: mockDataPickerRepository,
  );

  await tester.pumpApp(const ProfileScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.profile.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerUserWatcherBloc(
  UserRepository mockUserRepository,
) {
  final userWatcherBloc = UserWatcherBloc(
    userRepository: mockUserRepository,
  );
  if (GetIt.I.isRegistered<UserWatcherBloc>()) {
    GetIt.I.unregister<UserWatcherBloc>();
  }
  GetIt.I.registerSingleton<UserWatcherBloc>(userWatcherBloc);
}

void _registerProfileBloc({
  required UserRepository mockUserRepository,
  required IDataPickerRepository mockDataPickerRepository,
}) {
  final profileBloc = ProfileBloc(
    userRepository: mockUserRepository,
    dataPickerRepository: mockDataPickerRepository,
  );
  if (GetIt.I.isRegistered<ProfileBloc>()) {
    GetIt.I.unregister<ProfileBloc>();
  }
  GetIt.I.registerSingleton<ProfileBloc>(profileBloc);
}
