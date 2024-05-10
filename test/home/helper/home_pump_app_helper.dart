import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> homePumpAppHelper({
  required IFeedbackRepository mockFeedbackRepository,
  required IHomeRepository mockHomeRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerFeedbackBloc(mockFeedbackRepository: mockFeedbackRepository);
  _registerHomeBloc(mockHomeRepository: mockHomeRepository);
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  await tester.pumpApp(
    const HomeScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(find.byKey(KWidgetkeys.screen.home.screen), findsOneWidget);

  await tester.pumpAndSettle();
}

void _registerFeedbackBloc({
  required IFeedbackRepository mockFeedbackRepository,
}) {
  final feedbackBloc = FeedbackBloc(feedbackRepository: mockFeedbackRepository);
  if (GetIt.I.isRegistered<FeedbackBloc>()) {
    GetIt.I.unregister<FeedbackBloc>();
  }
  GetIt.I.registerSingleton<FeedbackBloc>(feedbackBloc);
}

void _registerHomeBloc({
  required IHomeRepository mockHomeRepository,
}) {
  final homeBloc = HomeWatcherBloc(homeRepository: mockHomeRepository);
  if (GetIt.I.isRegistered<HomeWatcherBloc>()) {
    GetIt.I.unregister<HomeWatcherBloc>();
  }
  GetIt.I.registerSingleton<HomeWatcherBloc>(homeBloc);
}

void _registerAuthenticationBloc({
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
