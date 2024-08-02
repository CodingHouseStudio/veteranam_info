// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i8;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart'
    as _i29;
import 'package:veteranam/components/discounts/bloc/link/discount_link_cubit.dart'
    as _i27;
import 'package:veteranam/components/discounts/bloc/link/discount_link_form_bloc.dart'
    as _i28;
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart'
    as _i30;
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart'
    as _i39;
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart' as _i32;
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart' as _i23;
import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart'
    as _i36;
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart'
    as _i31;
import 'package:veteranam/components/login/bloc/login_bloc.dart' as _i34;
import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart'
    as _i40;
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart'
    as _i37;
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart'
    as _i26;
import 'package:veteranam/components/privacy_policy/bloc/privacy_policy_markdown_cubit.dart'
    as _i35;
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart' as _i19;
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart'
    as _i22;
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart'
    as _i38;
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i41;
import 'package:veteranam/shared/bloc/authentication/authentication_bloc.dart'
    as _i43;
import 'package:veteranam/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i42;
import 'package:veteranam/shared/bloc/network/network_cubit.dart' as _i46;
import 'package:veteranam/shared/bloc/report/report_bloc.dart' as _i44;
import 'package:veteranam/shared/bloc/url/url_cubit.dart' as _i25;
import 'package:veteranam/shared/data_provider/cache_provider.dart' as _i3;
import 'package:veteranam/shared/data_provider/firestore_provider.dart' as _i4;
import 'package:veteranam/shared/data_provider/storage_provider.dart' as _i5;
import 'package:veteranam/shared/repositories/app_authentication_repository.dart'
    as _i16;
import 'package:veteranam/shared/repositories/app_nerwork_repository.dart'
    as _i24;
import 'package:veteranam/shared/repositories/authentication_repository.dart'
    as _i33;
import 'package:veteranam/shared/repositories/discount_repository.dart' as _i10;
import 'package:veteranam/shared/repositories/feedback_repository.dart' as _i11;
import 'package:veteranam/shared/repositories/firebase_module.dart' as _i47;
import 'package:veteranam/shared/repositories/home_repository.dart' as _i15;
import 'package:veteranam/shared/repositories/information_repository.dart'
    as _i20;
import 'package:veteranam/shared/repositories/investors_repository.dart'
    as _i14;
import 'package:veteranam/shared/repositories/network_module.dart' as _i48;
import 'package:veteranam/shared/repositories/network_repository.dart' as _i45;
import 'package:veteranam/shared/repositories/report_repository.dart' as _i21;
import 'package:veteranam/shared/repositories/secure_storage_repository.dart'
    as _i13;
import 'package:veteranam/shared/repositories/story_repository.dart' as _i17;
import 'package:veteranam/shared/repositories/url_repository.dart' as _i12;
import 'package:veteranam/shared/repositories/work_repository.dart' as _i18;
import 'package:veteranam/shared/shared.dart' as _i9;

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
    gh.factory<_i3.CacheClient>(() => _i3.CacheClient());
    gh.singleton<_i4.FirestoreService>(() => _i4.FirestoreService());
    gh.singleton<_i5.StorageService>(() => _i5.StorageService());
    gh.singleton<_i6.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i7.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i8.Connectivity>(() => networkModule.connectivity);
    gh.singleton<_i9.IDiscountRepository>(() => _i10.DiscountRepository());
    gh.singleton<_i9.IFeedbackRepository>(() => _i11.FeedbackRepository());
    gh.singleton<_i9.IUrlRepository>(() => _i12.UrlRepository());
    gh.lazySingleton<_i9.IStorage>(() => _i13.SecureStorageRepository());
    gh.singleton<_i9.IInvestorsRepository>(() => _i14.InvestorsRepository());
    gh.singleton<_i9.IHomeRepository>(() => _i15.HomeRepository());
    gh.singleton<_i9.IAppAuthenticationRepository>(
        () => _i16.AppAuthenticationRepository(
              gh<_i9.IStorage>(),
              gh<_i6.FirebaseAuth>(),
              gh<_i7.GoogleSignIn>(),
              gh<_i9.CacheClient>(),
            ));
    gh.lazySingleton<_i9.IStoryRepository>(() => _i17.StoryRepository());
    gh.lazySingleton<_i9.IWorkRepository>(() => _i18.WorkRepository());
    gh.factory<_i19.SignUpBloc>(() => _i19.SignUpBloc(
        iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>()));
    gh.lazySingleton<_i9.IInformationRepository>(
        () => _i20.InformationRepository());
    gh.lazySingleton<_i9.IReportRepository>(() => _i21.ReportRepository());
    gh.factory<_i22.StoryWatcherBloc>(() =>
        _i22.StoryWatcherBloc(storyRepository: gh<_i9.IStoryRepository>()));
    gh.factory<_i23.HomeWatcherBloc>(
        () => _i23.HomeWatcherBloc(homeRepository: gh<_i9.IHomeRepository>()));
    gh.singleton<_i9.IAppNetworkRepository>(() => _i24.AppNetworkRepository(
          gh<_i8.Connectivity>(),
          gh<_i9.CacheClient>(),
        ));
    gh.factory<_i25.UrlCubit>(
        () => _i25.UrlCubit(urlRepository: gh<_i9.IUrlRepository>()));
    gh.factory<_i26.NewsCardWatcherBloc>(() => _i26.NewsCardWatcherBloc(
        informationRepository: gh<_i9.IInformationRepository>()));
    gh.factory<_i27.DiscountLinkCubit>(() => _i27.DiscountLinkCubit(
          discountRepository: gh<_i9.IDiscountRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i28.DiscountLinkFormBloc>(() => _i28.DiscountLinkFormBloc(
          discountRepository: gh<_i9.IDiscountRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i29.DiscountCardWatcherBloc>(() => _i29.DiscountCardWatcherBloc(
        discountRepository: gh<_i9.IDiscountRepository>()));
    gh.factory<_i30.DiscountWatcherBloc>(() => _i30.DiscountWatcherBloc(
          discountRepository: gh<_i9.IDiscountRepository>(),
          reportRepository: gh<_i9.IReportRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i31.InvestorsWatcherBloc>(() => _i31.InvestorsWatcherBloc(
          investorsRepository: gh<_i9.IInvestorsRepository>(),
          reportRepository: gh<_i9.IReportRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i32.FeedbackBloc>(() => _i32.FeedbackBloc(
          feedbackRepository: gh<_i9.IFeedbackRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.singleton<_i33.AuthenticationRepository>(() =>
        _i33.AuthenticationRepository(gh<_i9.IAppAuthenticationRepository>()));
    gh.factory<_i34.LoginBloc>(() => _i34.LoginBloc(
        appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>()));
    gh.factory<_i35.PrivacyPolicyMarkdownCubit>(() =>
        _i35.PrivacyPolicyMarkdownCubit(
            appAuthenticationRepository:
                gh<_i9.IAppAuthenticationRepository>()));
    gh.factory<_i36.InformationWatcherBloc>(() => _i36.InformationWatcherBloc(
          informationRepository: gh<_i9.IInformationRepository>(),
          reportRepository: gh<_i9.IReportRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i37.MyStoryWatcherBloc>(() => _i37.MyStoryWatcherBloc(
          storyRepository: gh<_i9.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i38.StoryAddBloc>(() => _i38.StoryAddBloc(
          storyRepository: gh<_i9.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i39.EmployeeRespondBloc>(() => _i39.EmployeeRespondBloc(
        employeeRespondRepository: gh<_i9.IWorkRepository>()));
    gh.factory<_i40.MyDiscountsWatcherBloc>(() => _i40.MyDiscountsWatcherBloc(
          discountRepository: gh<_i9.IDiscountRepository>(),
          iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i41.WorkEmployeeWatcherBloc>(() => _i41.WorkEmployeeWatcherBloc(
        workRepository: gh<_i9.IWorkRepository>()));
    gh.factory<_i42.AuthenticationServicesCubit>(() =>
        _i42.AuthenticationServicesCubit(
            authenticationRepository: gh<_i9.AuthenticationRepository>()));
    gh.singleton<_i43.AuthenticationBloc>(() => _i43.AuthenticationBloc(
        authenticationRepository: gh<_i9.AuthenticationRepository>()));
    gh.factory<_i44.ReportBloc>(() => _i44.ReportBloc(
          reportRepository: gh<_i9.IReportRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.singleton<_i45.NetworkRepository>(
        () => _i45.NetworkRepository(gh<_i9.IAppNetworkRepository>()));
    gh.singleton<_i46.NetworkCubit>(() =>
        _i46.NetworkCubit(networkRepository: gh<_i9.NetworkRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i47.FirebaseModule {}

class _$NetworkModule extends _i48.NetworkModule {}
