import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/markdown_file_dialog/bloc/markdown_file_cubit.dart';
import 'package:veteranam/components/markdown_file_dialog/view/markdown_file_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
      startText: KTestVariables.field,
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
