import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> discountsPumpAppHelper({
  required WidgetTester tester,
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required IReportRepository mockReportRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerReportBloc(
    mockReportRepository: mockReportRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerDiscountBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    mockReportRepository: mockReportRepository,
  );
  _registerAuthenticationBloc(
    mockAuthenticationRepository: mockAuthenticationRepository,
  );
  _registerDiscountLinkFormBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerDiscountLinkCubit(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerDiscountUserEmailFormBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerDiscountUserEmailCubit(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerAdvancedFilterMobCubit();

  await tester.pumpApp(const DiscountsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(KWidgetkeys.screen.discounts.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

void _registerReportBloc({
  required IReportRepository mockReportRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final reportBloc = ReportBloc(
    reportRepository: mockReportRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<ReportBloc>()) {
    GetIt.I.unregister<ReportBloc>();
  }
  GetIt.I.registerSingleton<ReportBloc>(reportBloc);
}

void _registerDiscountBloc({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required IReportRepository mockReportRepository,
}) {
  final discountBloc = DiscountWatcherBloc(
    discountRepository: mockDiscountRepository,
    reportRepository: mockReportRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<DiscountWatcherBloc>()) {
    GetIt.I.unregister<DiscountWatcherBloc>();
  }
  GetIt.I.registerSingleton<DiscountWatcherBloc>(discountBloc);
}

void _registerAuthenticationBloc({
  required AuthenticationRepository mockAuthenticationRepository,
}) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}

void _registerDiscountLinkFormBloc({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  // final authenticationBloc = DiscountLinkFormBloc(
  //   discountRepository: mockDiscountRepository,
  //   appAuthenticationRepository: mockAppAuthenticationRepository,
  // );
  if (GetIt.I.isRegistered<DiscountLinkFormBloc>()) {
    GetIt.I.unregister<DiscountLinkFormBloc>();
  }
  GetIt.I.registerFactory<DiscountLinkFormBloc>(
    () => DiscountLinkFormBloc(
      discountRepository: mockDiscountRepository,
      appAuthenticationRepository: mockAppAuthenticationRepository,
    ),
  );
}

void _registerDiscountLinkCubit({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final authenticationBloc = DiscountLinkCubit(
    discountRepository: mockDiscountRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<DiscountLinkCubit>()) {
    GetIt.I.unregister<DiscountLinkCubit>();
  }
  GetIt.I.registerSingleton<DiscountLinkCubit>(authenticationBloc);
}

void _registerDiscountUserEmailFormBloc({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final authenticationBloc = DiscountUserEmailFormBloc(
    discountRepository: mockDiscountRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<DiscountUserEmailFormBloc>()) {
    GetIt.I.unregister<DiscountUserEmailFormBloc>();
  }
  GetIt.I.registerSingleton<DiscountUserEmailFormBloc>(authenticationBloc);
}

void _registerDiscountUserEmailCubit({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
}) {
  final authenticationBloc = DiscountUserEmailCubit(
    discountRepository: mockDiscountRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<DiscountUserEmailCubit>()) {
    GetIt.I.unregister<DiscountUserEmailCubit>();
  }
  GetIt.I.registerSingleton<DiscountUserEmailCubit>(authenticationBloc);
}

void _registerAdvancedFilterMobCubit() {
  final advancedFilterMobCubit = AdvancedFilterMobCubit();
  if (GetIt.I.isRegistered<AdvancedFilterMobCubit>()) {
    GetIt.I.unregister<AdvancedFilterMobCubit>();
  }
  GetIt.I.registerSingleton<AdvancedFilterMobCubit>(advancedFilterMobCubit);
}
