import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobFaqPumpAppHelper({
  required WidgetTester tester,
  required IFaqRepository mockFaqRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerMobFaqBloc(mockFaqRepository: mockFaqRepository);
  await tester.pumpApp(
    const MobFaqScreen(),
    mockGoRouter: mockGoRouter,
  );

  expect(find.byKey(KWidgetkeys.screen.mobFaq.screen), findsOneWidget);

  await tester.pumpAndSettle();
}

void _registerMobFaqBloc({
  required IFaqRepository mockFaqRepository,
}) {
  final homeBloc = MobFaqWatcherBloc(faqRepository: mockFaqRepository);
  if (GetIt.I.isRegistered<MobFaqWatcherBloc>()) {
    GetIt.I.unregister<MobFaqWatcherBloc>();
  }
  GetIt.I.registerSingleton<MobFaqWatcherBloc>(homeBloc);
}
