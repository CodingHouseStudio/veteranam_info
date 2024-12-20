import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/components/discounts/bloc/config/discount_config_cubit.dart';
import 'package:veteranam/components/discounts/bloc/link/discount_link_cubit.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discounts_watcher_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

Future<void> appPumpAppHelper({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required WidgetTester tester,
  required IFaqRepository mockFaqRepository,
  // required IReportRepository mockReportRepository,
  required IInvestorsRepository mockInvestorsReportisory,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
  required FirebaseAnalyticsService mockFirebaseAnalyticsService,
  required MobileRatingRepository mockMobileRatingRepository,
  required UserRepository mockUserRepository,
}) async {
  _registerAuthenticationBloc(mockAuthenticationRepository);
  _registerHomeBloc(mockFaqRepository);
  _registerDiscountBloc(
    mockDiscountRepository: mockDiscountRepository,
    // mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    // mockReportRepository: mockReportRepository,
    mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    mockUserRepository: mockUserRepository,
  );
  _registerDiscountLinkCubit(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerUserEmailFormBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
    // mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  _registerInvestorsBloc(
    mockInvestorsReportisory: mockInvestorsReportisory,
    // mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    // mockReportRepository: mockReportRepository,
  );
  _registerMobFaqBloc(mockFaqRepository);
  _registerDiscountConfigCubit(mockFirebaseRemoteConfigProvider);
  _registerMobileRatingCubit(mockMobileRatingRepository);
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

void _registerUserEmailFormBloc({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required FirebaseAnalyticsService mockFirebaseAnalyticsService,
}) {
  final userEmailFormBloc = UserEmailFormBloc(
    discountRepository: mockDiscountRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
    firebaseAnalyticsService: mockFirebaseAnalyticsService,
    // firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (GetIt.I.isRegistered<UserEmailFormBloc>()) {
    GetIt.I.unregister<UserEmailFormBloc>();
  }
  GetIt.I.registerSingleton<UserEmailFormBloc>(userEmailFormBloc);
}

void _registerDiscountBloc({
  required IDiscountRepository mockDiscountRepository,
  // required IAppAuthenticationRepository mockAppAuthenticationRepository,
  // required IReportRepository mockReportRepository,
  required UserRepository mockUserRepository,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
}) {
  final discountBloc = DiscountsWatcherBloc(
    discountRepository: mockDiscountRepository,
    // reportRepository: mockReportRepository,
    // appAuthenticationRepository: mockAppAuthenticationRepository,
    firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (GetIt.I.isRegistered<DiscountsWatcherBloc>()) {
    GetIt.I.unregister<DiscountsWatcherBloc>();
  }
  GetIt.I.registerSingleton<DiscountsWatcherBloc>(discountBloc);
  if (GetIt.I.isRegistered<UserRepository>()) {
    GetIt.I.unregister<UserRepository>();
  }
  GetIt.I.registerSingleton<UserRepository>(mockUserRepository);
}

void _registerInvestorsBloc({
  required IInvestorsRepository mockInvestorsReportisory,
  // required IAppAuthenticationRepository mockAppAuthenticationRepository,
  // required IReportRepository mockReportRepository,
}) {
  final investorsBloc = InvestorsWatcherBloc(
    investorsRepository: mockInvestorsReportisory,
    // reportRepository: mockReportRepository,
    // appAuthenticationRepository: mockAppAuthenticationRepository,
  );
  if (GetIt.I.isRegistered<InvestorsWatcherBloc>()) {
    GetIt.I.unregister<InvestorsWatcherBloc>();
  }
  GetIt.I.registerSingleton<InvestorsWatcherBloc>(investorsBloc);
}

void _registerMobFaqBloc(IFaqRepository mockFaqRepository) {
  final mobFaqBloc = MobFaqWatcherBloc(
    faqRepository: mockFaqRepository,
  );
  if (GetIt.I.isRegistered<MobFaqWatcherBloc>()) {
    GetIt.I.unregister<MobFaqWatcherBloc>();
  }
  GetIt.I.registerSingleton<MobFaqWatcherBloc>(mobFaqBloc);
}

void _registerDiscountConfigCubit(
  FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
) {
  final discountConfigCubit = DiscountConfigCubit(
    firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (GetIt.I.isRegistered<DiscountConfigCubit>()) {
    GetIt.I.unregister<DiscountConfigCubit>();
  }
  GetIt.I.registerSingleton<DiscountConfigCubit>(discountConfigCubit);
}

void _registerMobileRatingCubit(
  MobileRatingRepository mockMobileRatingRepository,
) {
  final mobileRatingCubit = MobileRatingCubit(
    mobileRatingRepository: mockMobileRatingRepository,
  );
  if (GetIt.I.isRegistered<MobileRatingCubit>()) {
    GetIt.I.unregister<MobileRatingCubit>();
  }
  GetIt.I.registerSingleton<MobileRatingCubit>(mobileRatingCubit);
}
