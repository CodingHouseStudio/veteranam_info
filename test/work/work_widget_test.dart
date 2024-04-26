import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../bloc/authentication_bloc_unit_test.dart';
import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.work} ', () {
    late AuthenticationRepository mockAuthenticationRepository;
    late AuthenticationBloc authenticationBloc;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepositoryUnitTest();
    });
    void registerAuthenticationBloc() {
      authenticationBloc = AuthenticationBloc(
        authenticationRepository: mockAuthenticationRepository,
      );
      if (GetIt.I.isRegistered<AuthenticationBloc>()) {
        GetIt.I.unregister<AuthenticationBloc>();
      }
      GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerAuthenticationBloc();
      await tester.pumpApp(const WorkScreen());

      expect(
        find.byKey(KWidgetkeys.screen.work.screen),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await nawbarHelper(tester: tester, searchText: KTestText.field);

      await workCardHelper(tester);

      await footerHelper(tester);
    });
    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.intial} ', (tester) async {
        registerAuthenticationBloc();
        await tester.pumpApp(const WorkScreen(), mockGoRouter: mockGoRouter);

        expect(
          find.byKey(KWidgetkeys.screen.work.screen),
          findsOneWidget,
        );

        await tester.pumpAndSettle();

        await nawbarHelper(tester: tester, searchText: KTestText.field);

        await workCardHelper(tester);
      });
      // group('${KGroupText.goTo} ', () {
      // });
    });
  });
}
