import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> privacyPolicyPumpAppHelper({
  required WidgetTester tester,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerPrivacyPolicyMarkdownCubit(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  await tester.pumpApp(const PrivacyPolicyDialog(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerPrivacyPolicyMarkdownCubit({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final privacyPolicyMarkdownCubit = PrivacyPolicyMarkdownCubit(
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<PrivacyPolicyMarkdownCubit>()) {
    GetIt.I.unregister<PrivacyPolicyMarkdownCubit>();
  }
  GetIt.I.registerSingleton<PrivacyPolicyMarkdownCubit>(
    privacyPolicyMarkdownCubit,
  );
}
