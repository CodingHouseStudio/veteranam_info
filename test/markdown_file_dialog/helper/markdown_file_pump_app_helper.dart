import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> markdownFileDialogPumpAppHelper({
  required WidgetTester tester,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerPrivacyPolicyMarkdownCubit(
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  await tester.pumpApp(
    const MarkdownFileDialog(
      ukFilePath: KAppText.ukPrivacyPolicyPath,
      enFilePath: KAppText.enPrivacyPolicyPath,
      startText: KTestText.field,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerPrivacyPolicyMarkdownCubit({
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final privacyPolicyMarkdownCubit = MarkdownFileCubit(
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<MarkdownFileCubit>()) {
    GetIt.I.unregister<MarkdownFileCubit>();
  }
  GetIt.I.registerSingleton<MarkdownFileCubit>(
    privacyPolicyMarkdownCubit,
  );
}
