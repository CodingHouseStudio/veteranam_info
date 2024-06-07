import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> feedbackPumpAppHelper({
  required IFeedbackRepository mockFeedbackRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerFeedbackBloc(
    mockFeedbackRepository: mockFeedbackRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  await tester.pumpApp(const FeedbackScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.feedback.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerFeedbackBloc({
  required IFeedbackRepository mockFeedbackRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final feedbackBloc = FeedbackBloc(
    feedbackRepository: mockFeedbackRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<FeedbackBloc>()) {
    GetIt.I.unregister<FeedbackBloc>();
  }
  GetIt.I.registerSingleton<FeedbackBloc>(feedbackBloc);
}
