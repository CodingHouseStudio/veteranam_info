import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> investorsPumpAppHelper({
  required IFeedbackRepository mockFeedbackRepository,
  required IInvestorsRepository mockInvestorsRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  _registerFeedbackBloc(
    mockFeedbackRepository: mockFeedbackRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerInvestorsBloc(mockInvestorsRepository: mockInvestorsRepository);
  await tester.pumpApp(const InvestorsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.investors.screen),
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

void _registerInvestorsBloc({
  required IInvestorsRepository mockInvestorsRepository,
}) {
  final investorsBloc =
      InvestorsWatcherBloc(investorsRepository: mockInvestorsRepository);
  if (GetIt.I.isRegistered<InvestorsWatcherBloc>()) {
    GetIt.I.unregister<InvestorsWatcherBloc>();
  }
  GetIt.I.registerSingleton<InvestorsWatcherBloc>(investorsBloc);
}
