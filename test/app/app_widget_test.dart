import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/app.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group(KScreenBlocName.app, () {
    late IHomeRepository mockHomeRepository;
    late HomeWatcherBloc homeBloc;
    setUp(() {
      ExtendedDateTime.customTime = KTestText.feedbackModel.timestamp;
      mockHomeRepository = MockIHomeRepository();
      when(mockHomeRepository.getQuestions()).thenAnswer(
        (invocation) async => const Right(KTestText.questionModelItems),
      );
    });
    void registerHomeBloc() {
      homeBloc = HomeWatcherBloc(homeRepository: mockHomeRepository);
      if (GetIt.I.isRegistered<HomeWatcherBloc>()) {
        GetIt.I.unregister<HomeWatcherBloc>();
      }
      GetIt.I.registerSingleton<HomeWatcherBloc>(homeBloc);
    }

    testWidgets(KGroupText.intial, (tester) async {
      registerHomeBloc();
      await tester.pumpWidget(const App());

      expect(
        find.byKey(KWidgetkeys.screen.app.screen),
        findsOneWidget,
      );

      await nawbarHelper(tester: tester, searchText: KTestText.field);

      await footerHelper(tester: tester, email: KTestText.useremail);
    });
  });
}
