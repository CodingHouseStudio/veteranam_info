import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> newsCardPumpAppHelper({
  required WidgetTester tester,
  required IInformationRepository mockNewsRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerNewsCardBloc(mockNewsRepository: mockNewsRepository);
  await tester.pumpApp(
    NewsCardDialog(id: KTestText.informationModelItems.first.id),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.newsCard.dialog),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerNewsCardBloc({
  required IInformationRepository mockNewsRepository,
}) {
  final newsCardBloc = NewsCardWatcherBloc(
    informationRepository: mockNewsRepository,
  );
  if (GetIt.I.isRegistered<NewsCardWatcherBloc>()) {
    GetIt.I.unregister<NewsCardWatcherBloc>();
  }
  GetIt.I.registerSingleton<NewsCardWatcherBloc>(newsCardBloc);
}
