import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart';
import 'package:veteranam/components/news_card/view/news_card_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> newsCardPumpAppHelper({
  required WidgetTester tester,
  required IInformationRepository mockNewsRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerNewsCardBloc(mockNewsRepository: mockNewsRepository);
  await tester.pumpApp(
    NewsCardDialog(id: KTestVariables.informationModelItems.first.id),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(NewsCardDialogKeys.dialog),
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
