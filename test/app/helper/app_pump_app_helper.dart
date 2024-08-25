import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> appPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  required IFaqRepository mockFaqRepository,
  required IReportRepository mockReportRepository,
  required IInvestorsRepository mockInvestorsReportisory,
}) async {
  _registerAuthenticationBloc(mockAuthenticationRepository);
  _registerHomeBloc(mockFaqRepository);
  _registerDiscountBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    mockReportRepository: mockReportRepository,
  );
  _registerDiscountLinkCubit(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerDiscountUserEmailCubit(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registreInvestorsBloc(
    mockInvestorsReportisory: mockInvestorsReportisory,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    mockReportRepository: mockReportRepository,
  );
  _registremMobFaqBloc(mockFaqRepository);
  await tester.pumpWidget(const App());

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.screen.app.screen),
    findsOneWidget,
  );
}

void _registerAuthenticationBloc(
  AuthenticationRepository mockAuthenticationRepository,
) {
  final authenticationBloc = AuthenticationBloc(
    authenticationRepository: mockAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<AuthenticationBloc>()) {
    GetIt.I.unregister<AuthenticationBloc>();
  }
  GetIt.I.registerSingleton<AuthenticationBloc>(authenticationBloc);
}

void _registerHomeBloc(IFaqRepository mockFaqRepository) {
  final homeBloc = HomeWatcherBloc(faqRepository: mockFaqRepository);
  if (GetIt.I.isRegistered<HomeWatcherBloc>()) {
    GetIt.I.unregister<HomeWatcherBloc>();
  }
  GetIt.I.registerSingleton<HomeWatcherBloc>(homeBloc);
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

void _registreInvestorsBloc({
  required IInvestorsRepository mockInvestorsReportisory,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required IReportRepository mockReportRepository,
}) {
  final investorsBloc = InvestorsWatcherBloc(
    investorsRepository: mockInvestorsReportisory,
    reportRepository: mockReportRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<InvestorsWatcherBloc>()) {
    GetIt.I.unregister<InvestorsWatcherBloc>();
  }
  GetIt.I.registerSingleton<InvestorsWatcherBloc>(investorsBloc);
}

void _registremMobFaqBloc(IFaqRepository mockFaqRepository) {
  final mobFaqBloc = MobFaqWatcherBloc(
    faqRepository: mockFaqRepository,
  );
  if (GetIt.I.isRegistered<MobFaqWatcherBloc>()) {
    GetIt.I.unregister<MobFaqWatcherBloc>();
  }
  GetIt.I.registerSingleton<MobFaqWatcherBloc>(mobFaqBloc);
}
