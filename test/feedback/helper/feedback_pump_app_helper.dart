import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/components/feedback/view/feedback_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> feedbackPumpAppHelper({
  required IFeedbackRepository mockFeedbackRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required WidgetTester tester,
  required IUrlRepository mockUrlRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerFeedbackBloc(
    mockFeedbackRepository: mockFeedbackRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerUrlCubit(mockUrlRepository);
  await tester.pumpApp(const FeedbackScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(FeedbackKeys.screen),
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

void _registerUrlCubit(
  IUrlRepository mockUrlRepository,
) {
  final urlCubit = UrlCubit(
    urlRepository: mockUrlRepository,
  );
  if (GetIt.I.isRegistered<UrlCubit>()) {
    GetIt.I.unregister<UrlCubit>();
  }
  GetIt.I.registerSingleton<UrlCubit>(urlCubit);
}
