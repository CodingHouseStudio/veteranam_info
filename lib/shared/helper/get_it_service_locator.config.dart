// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i9;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart'
    as _i30;
import 'package:veteranam/components/discounts/bloc/advanced_filter_mob_cubit.dart'
    as _i3;
import 'package:veteranam/components/discounts/bloc/link/discount_link_cubit.dart'
    as _i28;
import 'package:veteranam/components/discounts/bloc/link/discount_link_form_bloc.dart'
    as _i29;
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart'
    as _i31;
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart'
    as _i40;
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart' as _i33;
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart' as _i24;
import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart'
    as _i37;
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart'
    as _i32;
import 'package:veteranam/components/login/bloc/login_bloc.dart' as _i35;
import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart'
    as _i41;
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart'
    as _i38;
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart'
    as _i27;
import 'package:veteranam/components/privacy_policy/bloc/privacy_policy_markdown_cubit.dart'
    as _i36;
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart' as _i20;
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart'
    as _i23;
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart'
    as _i39;
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i42;
import 'package:veteranam/shared/bloc/authentication/authentication_bloc.dart'
    as _i44;
import 'package:veteranam/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i43;
import 'package:veteranam/shared/bloc/network/network_cubit.dart' as _i47;
import 'package:veteranam/shared/bloc/report/report_bloc.dart' as _i45;
import 'package:veteranam/shared/bloc/url/url_cubit.dart' as _i26;
import 'package:veteranam/shared/data_provider/cache_provider.dart' as _i4;
import 'package:veteranam/shared/data_provider/firestore_provider.dart' as _i5;
import 'package:veteranam/shared/data_provider/storage_provider.dart' as _i6;
import 'package:veteranam/shared/repositories/app_authentication_repository.dart'
    as _i17;
import 'package:veteranam/shared/repositories/app_nerwork_repository.dart'
    as _i25;
import 'package:veteranam/shared/repositories/authentication_repository.dart'
    as _i34;
import 'package:veteranam/shared/repositories/discount_repository.dart' as _i11;
import 'package:veteranam/shared/repositories/feedback_repository.dart' as _i12;
import 'package:veteranam/shared/repositories/firebase_module.dart' as _i48;
import 'package:veteranam/shared/repositories/home_repository.dart' as _i16;
import 'package:veteranam/shared/repositories/information_repository.dart'
    as _i21;
import 'package:veteranam/shared/repositories/investors_repository.dart'
    as _i15;
import 'package:veteranam/shared/repositories/network_module.dart' as _i49;
import 'package:veteranam/shared/repositories/network_repository.dart' as _i46;
import 'package:veteranam/shared/repositories/report_repository.dart' as _i22;
import 'package:veteranam/shared/repositories/secure_storage_repository.dart'
    as _i14;
import 'package:veteranam/shared/repositories/story_repository.dart' as _i18;
import 'package:veteranam/shared/repositories/url_repository.dart' as _i13;
import 'package:veteranam/shared/repositories/work_repository.dart' as _i19;
import 'package:veteranam/shared/shared.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i3.AdvancedFilterMobCubit>(() => _i3.AdvancedFilterMobCubit());
    gh.factory<_i4.CacheClient>(() => _i4.CacheClient());
    gh.singleton<_i5.FirestoreService>(() => _i5.FirestoreService());
    gh.singleton<_i6.StorageService>(() => _i6.StorageService());
    gh.singleton<_i7.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i8.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i9.Connectivity>(() => networkModule.connectivity);
    gh.singleton<_i10.IDiscountRepository>(() => _i11.DiscountRepository());
    gh.singleton<_i10.IFeedbackRepository>(() => _i12.FeedbackRepository());
    gh.singleton<_i10.IUrlRepository>(() => _i13.UrlRepository());
    gh.lazySingleton<_i10.IStorage>(() => _i14.SecureStorageRepository());
    gh.singleton<_i10.IInvestorsRepository>(() => _i15.InvestorsRepository());
    gh.singleton<_i10.IHomeRepository>(() => _i16.HomeRepository());
    gh.singleton<_i10.IAppAuthenticationRepository>(
        () => _i17.AppAuthenticationRepository(
              gh<_i10.IStorage>(),
              gh<_i7.FirebaseAuth>(),
              gh<_i8.GoogleSignIn>(),
              gh<_i10.CacheClient>(),
            ));
    gh.lazySingleton<_i10.IStoryRepository>(() => _i18.StoryRepository());
    gh.lazySingleton<_i10.IWorkRepository>(() => _i19.WorkRepository());
    gh.factory<_i20.SignUpBloc>(() => _i20.SignUpBloc(
        iAppAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>()));
    gh.lazySingleton<_i10.IInformationRepository>(
        () => _i21.InformationRepository());
    gh.lazySingleton<_i10.IReportRepository>(() => _i22.ReportRepository());
    gh.factory<_i23.StoryWatcherBloc>(() =>
        _i23.StoryWatcherBloc(storyRepository: gh<_i10.IStoryRepository>()));
    gh.factory<_i24.HomeWatcherBloc>(
        () => _i24.HomeWatcherBloc(homeRepository: gh<_i10.IHomeRepository>()));
    gh.singleton<_i10.IAppNetworkRepository>(() => _i25.AppNetworkRepository(
          gh<_i9.Connectivity>(),
          gh<_i10.CacheClient>(),
        ));
    gh.factory<_i26.UrlCubit>(
        () => _i26.UrlCubit(urlRepository: gh<_i10.IUrlRepository>()));
    gh.factory<_i27.NewsCardWatcherBloc>(() => _i27.NewsCardWatcherBloc(
        informationRepository: gh<_i10.IInformationRepository>()));
    gh.factory<_i28.DiscountLinkCubit>(() => _i28.DiscountLinkCubit(
          discountRepository: gh<_i10.IDiscountRepository>(),
          appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i29.DiscountLinkFormBloc>(() => _i29.DiscountLinkFormBloc(
          discountRepository: gh<_i10.IDiscountRepository>(),
          appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i30.DiscountCardWatcherBloc>(() => _i30.DiscountCardWatcherBloc(
        discountRepository: gh<_i10.IDiscountRepository>()));
    gh.factory<_i31.DiscountWatcherBloc>(() => _i31.DiscountWatcherBloc(
          discountRepository: gh<_i10.IDiscountRepository>(),
          reportRepository: gh<_i10.IReportRepository>(),
          appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i32.InvestorsWatcherBloc>(() => _i32.InvestorsWatcherBloc(
          investorsRepository: gh<_i10.IInvestorsRepository>(),
          reportRepository: gh<_i10.IReportRepository>(),
          appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i33.FeedbackBloc>(() => _i33.FeedbackBloc(
          feedbackRepository: gh<_i10.IFeedbackRepository>(),
          appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.singleton<_i34.AuthenticationRepository>(() =>
        _i34.AuthenticationRepository(gh<_i10.IAppAuthenticationRepository>()));
    gh.factory<_i35.LoginBloc>(() => _i35.LoginBloc(
        appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>()));
    gh.factory<_i36.PrivacyPolicyMarkdownCubit>(() =>
        _i36.PrivacyPolicyMarkdownCubit(
            appAuthenticationRepository:
                gh<_i10.IAppAuthenticationRepository>()));
    gh.factory<_i37.InformationWatcherBloc>(() => _i37.InformationWatcherBloc(
          informationRepository: gh<_i10.IInformationRepository>(),
          reportRepository: gh<_i10.IReportRepository>(),
          appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i38.MyStoryWatcherBloc>(() => _i38.MyStoryWatcherBloc(
          storyRepository: gh<_i10.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i39.StoryAddBloc>(() => _i39.StoryAddBloc(
          storyRepository: gh<_i10.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i40.EmployeeRespondBloc>(() => _i40.EmployeeRespondBloc(
        employeeRespondRepository: gh<_i10.IWorkRepository>()));
    gh.factory<_i41.MyDiscountsWatcherBloc>(() => _i41.MyDiscountsWatcherBloc(
          discountRepository: gh<_i10.IDiscountRepository>(),
          iAppAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i42.WorkEmployeeWatcherBloc>(() => _i42.WorkEmployeeWatcherBloc(
        workRepository: gh<_i10.IWorkRepository>()));
    gh.factory<_i43.AuthenticationServicesCubit>(() =>
        _i43.AuthenticationServicesCubit(
            authenticationRepository: gh<_i10.AuthenticationRepository>()));
    gh.singleton<_i44.AuthenticationBloc>(() => _i44.AuthenticationBloc(
        authenticationRepository: gh<_i10.AuthenticationRepository>()));
    gh.factory<_i45.ReportBloc>(() => _i45.ReportBloc(
          reportRepository: gh<_i10.IReportRepository>(),
          appAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.singleton<_i46.NetworkRepository>(
        () => _i46.NetworkRepository(gh<_i10.IAppNetworkRepository>()));
    gh.singleton<_i47.NetworkCubit>(() =>
        _i47.NetworkCubit(networkRepository: gh<_i10.NetworkRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i48.FirebaseModule {}

class _$NetworkModule extends _i49.NetworkModule {}
