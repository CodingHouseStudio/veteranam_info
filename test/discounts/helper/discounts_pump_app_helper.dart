import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/view/discounts_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

Future<void> discountsPumpAppHelper({
  required WidgetTester tester,
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required IReportRepository mockReportRepository,
  required AuthenticationRepository mockAuthenticationRepository,
  required FirebaseAnalyticsService mockFirebaseAnalyticsService,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
  required AppInfoRepository mockBuildRepository,
  required MobileRatingRepository? mockMobileRatingRepository,
  required UserRepository mockUserRepository,
  MockGoRouter? mockGoRouter,
}) async {
  _registerReportBloc(
    mockReportRepository: mockReportRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  );
  _registerDiscountBloc(
    mockDiscountRepository: mockDiscountRepository,
    // mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    // mockReportRepository: mockReportRepository,
    mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    mockUserRepository: mockUserRepository,
  );
  _registerUserWatcherBloc(
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
  _registerUserEmailFormBloc(
    mockDiscountRepository: mockDiscountRepository,
    mockAppAuthenticationRepository: mockAppAuthenticationRepository,
    mockFirebaseAnalyticsService: mockFirebaseAnalyticsService,
  );
  // _registerDiscountUserEmailCubit(
  //   mockDiscountRepository: mockDiscountRepository,
  //   mockAppAuthenticationRepository: mockAppAuthenticationRepository,
  //   // mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  // );
  // _registerAdvancedFilterMobCubit();
  _registerDiscountConfigCubit(mockFirebaseRemoteConfigProvider);
  _registerBuildCubit(
    mockBuildRepository: mockBuildRepository,
    mockFirebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (mockMobileRatingRepository != null) {
    _registerMobileRatingCubit(mockMobileRatingRepository);
  }

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
  // required IAppAuthenticationRepository mockAppAuthenticationRepository,
  // required IReportRepository mockReportRepository,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
  required UserRepository mockUserRepository,
}) {
  final discountBloc = DiscountWatcherBloc(
    discountRepository: mockDiscountRepository,
    // reportRepository: mockReportRepository,
    // appAuthenticationRepository: mockAppAuthenticationRepository,
    firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
    userRepository: mockUserRepository,
  );
  if (GetIt.I.isRegistered<DiscountWatcherBloc>()) {
    GetIt.I.unregister<DiscountWatcherBloc>();
  }
  GetIt.I.registerSingleton<DiscountWatcherBloc>(discountBloc);
}

void _registerUserWatcherBloc({
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

void _registerUserEmailFormBloc({
  required IDiscountRepository mockDiscountRepository,
  required IAppAuthenticationRepository mockAppAuthenticationRepository,
  required FirebaseAnalyticsService mockFirebaseAnalyticsService,
}) {
  final authenticationBloc = UserEmailFormBloc(
    discountRepository: mockDiscountRepository,
    appAuthenticationRepository: mockAppAuthenticationRepository,
    firebaseAnalyticsService: mockFirebaseAnalyticsService,
  );
  if (GetIt.I.isRegistered<UserEmailFormBloc>()) {
    GetIt.I.unregister<UserEmailFormBloc>();
  }
  GetIt.I.registerSingleton<UserEmailFormBloc>(authenticationBloc);
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

// void _registerDiscountUserEmailCubit({
//   required IDiscountRepository mockDiscountRepository,
//   required IAppAuthenticationRepository mockAppAuthenticationRepository,
//   // required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
// }) {
//   final authenticationBloc = DiscountUserEmailCubit(
//     discountRepository: mockDiscountRepository,
//     appAuthenticationRepository: mockAppAuthenticationRepository,
//     // firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
//   );
//   if (GetIt.I.isRegistered<DiscountUserEmailCubit>()) {
//     GetIt.I.unregister<DiscountUserEmailCubit>();
//   }
//   GetIt.I.registerSingleton<DiscountUserEmailCubit>(authenticationBloc);
// }

// void _registerAdvancedFilterMobCubit() {
//   final advancedFilterMobCubit = AdvancedFilterMobCubit();
//   if (GetIt.I.isRegistered<AdvancedFilterMobCubit>()) {
//     GetIt.I.unregister<AdvancedFilterMobCubit>();
//   }
//   GetIt.I.registerSingleton<AdvancedFilterMobCubit>(advancedFilterMobCubit);
// }

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

void _registerBuildCubit({
  required AppInfoRepository mockBuildRepository,
  required FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider,
}) {
  final buildCubit = AppVersionCubit(
    buildRepository: mockBuildRepository,
    firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (GetIt.I.isRegistered<AppVersionCubit>()) {
    GetIt.I.unregister<AppVersionCubit>();
  }
  GetIt.I.registerSingleton<AppVersionCubit>(buildCubit);
}
