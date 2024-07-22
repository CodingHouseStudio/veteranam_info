import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/app.dart';
// ignore: unused_import
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.app} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      KPlatformConstants.kIsWeb = true;
      mockAuthenticationRepository = MockAuthenticationRepository();
      when(mockAuthenticationRepository.userSetting).thenAnswer(
        (realInvocation) => Stream.value(UserSetting.empty),
      );
      when(mockAuthenticationRepository.status).thenAnswer(
        (realInvocation) => Stream.value(AuthenticationStatus.anonymous),
      );
      when(mockAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => User.empty,
      );
      when(mockAuthenticationRepository.currentUserSetting).thenAnswer(
        (realInvocation) => UserSetting.empty,
      );
    });

    void registerAuthenticationBloc({
      required AuthenticationRepository mockAuthenticationRepository,
    }) {
      final authenticationBloc = AuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<AuthenticationBloc>()) {
        GetIt.I.unregister<AuthenticationBloc>();
      }
      GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerAuthenticationBloc(
        mockAuthenticationRepository: mockAuthenticationRepository,
      );
      await tester.pumpWidget(const App());

      await tester.pumpAndSettle();

      expect(
        find.byKey(KWidgetkeys.screen.app.screen),
        findsOneWidget,
      );
    });
  });
}
