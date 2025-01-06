import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/components/discount/view/discount_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> discountPumpAppHelper({
  required WidgetTester tester,
  required IDiscountRepository mockDiscountRepository,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
  required IUrlRepository mockUrlRepository,
  required IReportRepository mockReportRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  String? discountId = KTestVariables.id,
  DiscountModel? discount,
  MockGoRouter? mockGoRouter,
}) async {
  _registerDiscountWatcherBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  _registerUrlCubit(mockUrlRepository);
  _registerReportBloc(
    mockReportRepository: mockReportRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );

  await tester.pumpApp(
    DiscountScreen(
      discountId: discountId,
      discount: discount,
    ),
    mockGoRouter: mockGoRouter,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discount.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerDiscountWatcherBloc({
  required IDiscountRepository mockDiscountRepository,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
}) {
  if (GetIt.I.isRegistered<DiscountWatcherBloc>()) {
    GetIt.I.unregister<DiscountWatcherBloc>();
  }
  GetIt.I.registerFactoryParam<DiscountWatcherBloc, DiscountModel?, String?>(
    (discount, discountId) => DiscountWatcherBloc(
      discountRepository: mockDiscountRepository,
      discount: discount,
      discountId: discountId,
      firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    ),
  );
  // GetIt.I.registerSingleton<DiscountCardWatcherCubit>(discountCardBloc);
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

void _registerReportBloc({
  required IReportRepository mockReportRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  // final reportBloc = ReportBloc(
  //   reportRepository: mockReportRepository,
  //   appAuthenticationRepository: mockAppAuthenticationRepository,
  //   cardId: KTestVariables.id,
  //   card: CardEnum.discount,
  // );
  if (GetIt.I.isRegistered<ReportBloc>()) {
    GetIt.I.unregister<ReportBloc>();
  }
  GetIt.I.registerFactoryParam<ReportBloc, String, CardEnum>(
    (cardId, card) => ReportBloc(
      reportRepository: mockReportRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
      cardId: KTestVariables.id,
      card: CardEnum.funds,
    ),
  );
}
