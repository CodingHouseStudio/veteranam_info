import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/components/mob_faq/view/mob_faq_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

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

  expect(find.byKey(MobFaqKeys.screen), findsOneWidget);

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
