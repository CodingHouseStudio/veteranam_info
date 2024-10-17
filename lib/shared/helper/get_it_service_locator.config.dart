// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_analytics/firebase_analytics.dart' as _i398;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i806;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:veteranam/components/company/bloc/company_form_bloc.dart'
    as _i174;
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart'
    as _i334;
import 'package:veteranam/components/discounts/bloc/advanced_filter/advanced_filter_mob_cubit.dart'
    as _i189;
import 'package:veteranam/components/discounts/bloc/config/discount_config_cubit.dart'
    as _i43;
import 'package:veteranam/components/discounts/bloc/link/discount_link_cubit.dart'
    as _i227;
import 'package:veteranam/components/discounts/bloc/link/discount_link_form_bloc.dart'
    as _i372;
import 'package:veteranam/components/discounts/bloc/user_email/discount_user_email_form_bloc.dart'
    as _i441;
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart'
    as _i1006;
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart'
    as _i855;
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart'
    as _i675;
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart'
    as _i1026;
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart' as _i522;
import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart'
    as _i408;
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart'
    as _i609;
import 'package:veteranam/components/login/bloc/login_bloc.dart' as _i1025;
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart'
    as _i687;
import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart'
    as _i1032;
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart'
    as _i922;
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart'
    as _i688;
import 'package:veteranam/components/password_reset/bloc/check_code/check_verification_code_cubit.dart'
    as _i846;
import 'package:veteranam/components/password_reset/bloc/form/password_reset_bloc.dart'
    as _i335;
import 'package:veteranam/components/markdown_file_dialog/bloc/markdown_file_cubit.dart'
    as _i686;
import 'package:veteranam/components/profile/bloc/profile_bloc.dart' as _i492;
import 'package:veteranam/components/pw_reset_email/bloc/pw_reset_email_bloc.dart'
    as _i361;
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart' as _i785;
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart'
    as _i763;
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart'
    as _i716;
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i557;
import 'package:veteranam/shared/bloc/app_version/app_version_cubit.dart'
    as _i70;
import 'package:veteranam/shared/bloc/authentication/authentication_bloc.dart'
    as _i570;
import 'package:veteranam/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i209;
import 'package:veteranam/shared/bloc/company/company_watcher_bloc.dart'
    as _i86;
import 'package:veteranam/shared/bloc/mob_feedback/mob_feedback_bloc.dart'
    as _i872;
import 'package:veteranam/shared/bloc/mob_offline_mode/mob_offline_mode_cubit.dart'
    as _i43;
import 'package:veteranam/shared/bloc/network/network_cubit.dart' as _i891;
import 'package:veteranam/shared/bloc/report/report_bloc.dart' as _i765;
import 'package:veteranam/shared/bloc/url/url_cubit.dart' as _i319;
import 'package:veteranam/shared/data_provider/analytics_module.dart' as _i606;
import 'package:veteranam/shared/data_provider/cache_provider.dart' as _i37;
import 'package:veteranam/shared/data_provider/firebase_analytics_provider.dart'
    as _i777;
import 'package:veteranam/shared/data_provider/firebase_remote_config_provider.dart'
    as _i187;
import 'package:veteranam/shared/data_provider/firestore_module.dart' as _i718;
import 'package:veteranam/shared/data_provider/firestore_provider.dart'
    as _i1033;
import 'package:veteranam/shared/data_provider/image_load_helper.dart' as _i369;
import 'package:veteranam/shared/data_provider/image_load_module.dart' as _i163;
import 'package:veteranam/shared/data_provider/remote_config_module.dart'
    as _i769;
import 'package:veteranam/shared/data_provider/storage_module.dart' as _i812;
import 'package:veteranam/shared/data_provider/storage_provider.dart' as _i99;
import 'package:veteranam/shared/repositories/app_authentication_repository.dart'
    as _i99;
import 'package:veteranam/shared/repositories/app_info_repository.dart'
    as _i1008;
import 'package:veteranam/shared/repositories/app_nerwork_repository.dart'
    as _i336;
import 'package:veteranam/shared/repositories/authentication_repository.dart'
    as _i208;
import 'package:veteranam/shared/repositories/cities_repository.dart' as _i751;
import 'package:veteranam/shared/repositories/company_repository.dart' as _i115;
import 'package:veteranam/shared/repositories/data_picker_module.dart' as _i567;
import 'package:veteranam/shared/repositories/data_picker_repository.dart'
    as _i290;
import 'package:veteranam/shared/repositories/device_repository.dart' as _i712;
import 'package:veteranam/shared/repositories/discount_repository.dart'
    as _i452;
import 'package:veteranam/shared/repositories/failure_module.dart' as _i531;
import 'package:veteranam/shared/repositories/failure_repository.dart' as _i960;
import 'package:veteranam/shared/repositories/faq_repository.dart' as _i1007;
import 'package:veteranam/shared/repositories/feedback_repository.dart'
    as _i361;
import 'package:veteranam/shared/repositories/firebase_module.dart' as _i926;
import 'package:veteranam/shared/repositories/information_repository.dart'
    as _i154;
import 'package:veteranam/shared/repositories/investors_repository.dart'
    as _i994;
import 'package:veteranam/shared/repositories/messaging_module.dart' as _i967;
import 'package:veteranam/shared/repositories/network_module.dart' as _i385;
import 'package:veteranam/shared/repositories/network_repository.dart' as _i997;
import 'package:veteranam/shared/repositories/report_repository.dart' as _i205;
import 'package:veteranam/shared/repositories/secure_storage_repository.dart'
    as _i949;
import 'package:veteranam/shared/repositories/story_repository.dart' as _i801;
import 'package:veteranam/shared/repositories/url_repository.dart' as _i929;
import 'package:veteranam/shared/repositories/work_repository.dart' as _i76;
import 'package:veteranam/shared/shared.dart' as _i1001;

const String _user = 'user';
const String _mobile = 'mobile';
const String _business = 'business';
const String _development = 'development';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final failureModule = _$FailureModule();
    final firstoreModule = _$FirstoreModule();
    final artifactModule = _$ArtifactModule();
    final storageModule = _$StorageModule();
    final messagingModule = _$MessagingModule();
    final analytucsModule = _$AnalytucsModule();
    final remoteConfigModule = _$RemoteConfigModule();
    final dataPickerModule = _$DataPickerModule();
    final firebaseModule = _$FirebaseModule();
    final networkModule = _$NetworkModule();
    gh.singleton<_i141.FirebaseCrashlytics>(
        () => failureModule.firebaseCrashlytics);
    gh.factory<_i37.CacheClient>(() => _i37.CacheClient());
    gh.singleton<_i974.FirebaseFirestore>(() => firstoreModule.firestore);
    gh.singleton<_i361.Dio>(() => artifactModule.dio);
    gh.singleton<_i457.FirebaseStorage>(() => storageModule.storage);
    gh.singleton<_i1008.AppInfoRepository>(() => _i1008.AppInfoRepository());
    gh.singleton<_i892.FirebaseMessaging>(
        () => messagingModule.firebaseMessaging);
    gh.singleton<_i833.DeviceInfoPlugin>(
        () => messagingModule.deviceInfoPlugin);
    gh.lazySingleton<_i960.FailureRepository>(
        () => _i960.FailureRepository(gh<_i141.FirebaseCrashlytics>()));
    gh.singleton<_i99.StorageService>(
        () => _i99.StorageService(gh<_i457.FirebaseStorage>()));
    gh.singleton<_i369.ArtifactDownloadHelper>(
        () => _i369.ArtifactDownloadHelper(gh<_i361.Dio>()));
    gh.singleton<_i1033.FirestoreService>(() => _i1033.FirestoreService(
          gh<_i974.FirebaseFirestore>(),
          gh<_i1001.CacheClient>(),
        ));
    gh.singleton<_i1001.IDeviceRepository>(() => _i712.DeviceRepository(
          gh<_i892.FirebaseMessaging>(),
          gh<_i833.DeviceInfoPlugin>(),
          gh<_i1001.AppInfoRepository>(),
        ));
    gh.singleton<_i398.FirebaseAnalytics>(
        () => analytucsModule.firebaseAnalytics);
    gh.singleton<_i627.FirebaseRemoteConfig>(
        () => remoteConfigModule.firebaseRemoteConfig);
    gh.singleton<_i183.ImagePicker>(() => dataPickerModule.firebaseAuth);
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i806.FacebookAuth>(() => firebaseModule.firebaseSignIn);
    gh.singleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.singleton<_i1001.IDiscountRepository>(() => _i452.DiscountRepository());
    gh.singleton<_i1001.IFeedbackRepository>(() => _i361.FeedbackRepository());
    gh.singleton<_i1001.ICitiesRepository>(() => _i751.CitiesRepository());
    gh.lazySingleton<_i1001.IUrlRepository>(() => _i929.UrlRepository());
    gh.singleton<_i1001.IStorage>(() => _i949.SecureStorageRepository());
    gh.singleton<_i1001.IFaqRepository>(
      () => _i1007.FaqRepository(),
      registerFor: {
        _user,
        _mobile,
      },
    );
    gh.factory<_i687.MobFaqWatcherBloc>(
      () => _i687.MobFaqWatcherBloc(faqRepository: gh<_i1001.IFaqRepository>()),
      registerFor: {_mobile},
    );
    gh.singleton<_i1001.IInvestorsRepository>(
      () => _i994.InvestorsRepository(),
      registerFor: {_user},
    );
    gh.singleton<_i1001.IAppNetworkRepository>(() => _i336.AppNetworkRepository(
          gh<_i895.Connectivity>(),
          gh<_i1001.CacheClient>(),
        ));
    gh.singleton<_i1001.IDataPickerRepository>(
      () => _i290.DataPickerRepository(gh<_i183.ImagePicker>()),
      registerFor: {
        _business,
        _development,
      },
    );
    gh.factory<_i319.UrlCubit>(
        () => _i319.UrlCubit(urlRepository: gh<_i1001.IUrlRepository>()));
    gh.singleton<_i1001.IReportRepository>(
      () => _i205.ReportRepository(),
      registerFor: {_user},
    );
    gh.factory<_i334.DiscountCardWatcherBloc>(() =>
        _i334.DiscountCardWatcherBloc(
            discountRepository: gh<_i1001.IDiscountRepository>()));
    gh.singleton<_i1001.IStoryRepository>(
      () => _i801.StoryRepository(),
      registerFor: {_development},
    );
    gh.factory<_i189.AdvancedFilterMobCubit>(
      () => _i189.AdvancedFilterMobCubit(),
      registerFor: {_user},
    );
    gh.singleton<_i187.FirebaseRemoteConfigProvider>(() =>
        _i187.FirebaseRemoteConfigProvider(gh<_i627.FirebaseRemoteConfig>()));
    gh.singleton<_i1001.IInformationRepository>(
      () => _i154.InformationRepository(),
      registerFor: {_development},
    );
    gh.factory<_i763.StoryWatcherBloc>(
      () => _i763.StoryWatcherBloc(
          storyRepository: gh<_i1001.IStoryRepository>()),
      registerFor: {_development},
    );
    gh.factory<_i522.HomeWatcherBloc>(
      () => _i522.HomeWatcherBloc(faqRepository: gh<_i1001.IFaqRepository>()),
      registerFor: {_user},
    );
    gh.singleton<_i1001.IWorkRepository>(
      () => _i76.WorkRepository(),
      registerFor: {_development},
    );
    gh.factory<_i43.MobOfflineModeCubit>(
      () => _i43.MobOfflineModeCubit(
          firestoreService: gh<_i1001.FirestoreService>()),
      registerFor: {_mobile},
    );
    gh.factory<_i609.InvestorsWatcherBloc>(
      () => _i609.InvestorsWatcherBloc(
          investorsRepository: gh<_i1001.IInvestorsRepository>()),
      registerFor: {_user},
    );
    gh.factory<_i408.InformationWatcherBloc>(
      () => _i408.InformationWatcherBloc(
          informationRepository: gh<_i1001.IInformationRepository>()),
      registerFor: {_development},
    );
    gh.factory<_i688.NewsCardWatcherBloc>(
      () => _i688.NewsCardWatcherBloc(
          informationRepository: gh<_i1001.IInformationRepository>()),
      registerFor: {_development},
    );
    gh.singleton<_i1001.IAppAuthenticationRepository>(
        () => _i99.AppAuthenticationRepository(
              gh<_i1001.IStorage>(),
              gh<_i59.FirebaseAuth>(),
              gh<_i116.GoogleSignIn>(),
              gh<_i1001.CacheClient>(),
              gh<_i806.FacebookAuth>(),
            ));
    gh.factory<_i1006.DiscountWatcherBloc>(
      () => _i1006.DiscountWatcherBloc(
        discountRepository: gh<_i1001.IDiscountRepository>(),
        firebaseRemoteConfigProvider: gh<_i1001.FirebaseRemoteConfigProvider>(),
      ),
      registerFor: {_user},
    );
    gh.factory<_i43.DiscountConfigCubit>(
      () => _i43.DiscountConfigCubit(
          firebaseRemoteConfigProvider:
              gh<_i1001.FirebaseRemoteConfigProvider>()),
      registerFor: {_user},
    );
    gh.factory<_i227.DiscountLinkCubit>(
      () => _i227.DiscountLinkCubit(
        discountRepository: gh<_i1001.IDiscountRepository>(),
        appAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_user},
    );
    gh.singleton<_i997.NetworkRepository>(
        () => _i997.NetworkRepository(gh<_i1001.IAppNetworkRepository>()));
    gh.singleton<_i1001.ICompanyRepository>(
      () => _i115.CompanyRepository(
        gh<_i1001.IAppAuthenticationRepository>(),
        gh<_i1001.CacheClient>(),
      ),
      registerFor: {_business},
    );
    gh.factory<_i70.AppVersionCubit>(() => _i70.AppVersionCubit(
          buildRepository: gh<_i1001.AppInfoRepository>(),
          firebaseRemoteConfigProvider:
              gh<_i1001.FirebaseRemoteConfigProvider>(),
        ));
    gh.factory<_i872.MobFeedbackBloc>(
      () => _i872.MobFeedbackBloc(
        feedbackRepository: gh<_i1001.IFeedbackRepository>(),
        appAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_mobile},
    );
    gh.factory<_i765.ReportBloc>(
      () => _i765.ReportBloc(
        reportRepository: gh<_i1001.IReportRepository>(),
        appAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_user},
    );
    gh.factory<_i372.DiscountLinkFormBloc>(() => _i372.DiscountLinkFormBloc(
          discountRepository: gh<_i1001.IDiscountRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i86.CompanyWatcherBloc>(
      () => _i86.CompanyWatcherBloc(
          companyRepository: gh<_i1001.ICompanyRepository>()),
      registerFor: {_business},
    );
    gh.factory<_i557.WorkEmployeeWatcherBloc>(
      () => _i557.WorkEmployeeWatcherBloc(
          workRepository: gh<_i1001.IWorkRepository>()),
      registerFor: {_development},
    );
    gh.factory<_i675.EmployeeRespondBloc>(
      () => _i675.EmployeeRespondBloc(
        employeeRespondRepository: gh<_i1001.IWorkRepository>(),
        dataPickerRepository: gh<_i1001.IDataPickerRepository>(),
      ),
      registerFor: {_development},
    );
    gh.factory<_i1026.FeedbackBloc>(() => _i1026.FeedbackBloc(
          feedbackRepository: gh<_i1001.IFeedbackRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i855.DiscountsAddBloc>(
      () => _i855.DiscountsAddBloc(
        discountRepository: gh<_i1001.IDiscountRepository>(),
        companyRepository: gh<_i1001.ICompanyRepository>(),
        citiesRepository: gh<_i1001.ICitiesRepository>(),
      ),
      registerFor: {_business},
    );
    gh.singleton<_i208.AuthenticationRepository>(() =>
        _i208.AuthenticationRepository(
            gh<_i1001.IAppAuthenticationRepository>()));
    gh.factory<_i686.MarkdownFileCubit>(() => _i686.MarkdownFileCubit(
        appAuthenticationRepository:
            gh<_i1001.IAppAuthenticationRepository>()));
    gh.factory<_i1032.MyDiscountsWatcherBloc>(
      () => _i1032.MyDiscountsWatcherBloc(
        discountRepository: gh<_i1001.IDiscountRepository>(),
        companyRepository: gh<_i1001.ICompanyRepository>(),
      ),
      registerFor: {_business},
    );
    gh.factory<_i716.StoryAddBloc>(
      () => _i716.StoryAddBloc(
        storyRepository: gh<_i1001.IStoryRepository>(),
        iAppAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
        dataPickerRepository: gh<_i1001.IDataPickerRepository>(),
      ),
      registerFor: {_development},
    );
    gh.factory<_i922.MyStoryWatcherBloc>(
      () => _i922.MyStoryWatcherBloc(
        storyRepository: gh<_i1001.IStoryRepository>(),
        appAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_development},
    );
    gh.factory<_i174.CompanyFormBloc>(
      () => _i174.CompanyFormBloc(
        companyRepository: gh<_i1001.ICompanyRepository>(),
        dataPickerRepository: gh<_i1001.IDataPickerRepository>(),
        discountRepository: gh<_i1001.IDiscountRepository>(),
      ),
      registerFor: {_business},
    );
    gh.singleton<_i891.NetworkCubit>(() =>
        _i891.NetworkCubit(networkRepository: gh<_i1001.NetworkRepository>()));
    gh.factory<_i1025.LoginBloc>(() => _i1025.LoginBloc(
        authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.factory<_i846.CheckVerificationCodeCubit>(() =>
        _i846.CheckVerificationCodeCubit(
            authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.factory<_i335.PasswordResetBloc>(() => _i335.PasswordResetBloc(
        authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.factory<_i361.PwResetEmailBloc>(() => _i361.PwResetEmailBloc(
        authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.factory<_i785.SignUpBloc>(() => _i785.SignUpBloc(
        authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.factory<_i209.AuthenticationServicesCubit>(() =>
        _i209.AuthenticationServicesCubit(
            authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.singleton<_i570.AuthenticationBloc>(() => _i570.AuthenticationBloc(
        authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.singleton<_i777.FirebaseAnalyticsService>(
        () => _i777.FirebaseAnalyticsService(
              gh<_i398.FirebaseAnalytics>(),
              gh<_i1001.AuthenticationRepository>(),
            ));
    gh.factory<_i492.ProfileBloc>(() => _i492.ProfileBloc(
          authenticationRepository: gh<_i1001.AuthenticationRepository>(),
          dataPickerRepository: gh<_i1001.IDataPickerRepository>(),
        ));
    gh.factory<_i441.DiscountUserEmailFormBloc>(
      () => _i441.DiscountUserEmailFormBloc(
        discountRepository: gh<_i1001.IDiscountRepository>(),
        appAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
        firebaseAnalyticsService: gh<_i1001.FirebaseAnalyticsService>(),
      ),
      registerFor: {_user},
    );
    return this;
  }
}

class _$FailureModule extends _i531.FailureModule {}

class _$FirstoreModule extends _i718.FirstoreModule {}

class _$ArtifactModule extends _i163.ArtifactModule {}

class _$StorageModule extends _i812.StorageModule {}

class _$MessagingModule extends _i967.MessagingModule {}

class _$AnalytucsModule extends _i606.AnalytucsModule {}

class _$RemoteConfigModule extends _i769.RemoteConfigModule {}

class _$DataPickerModule extends _i567.DataPickerModule {}

class _$FirebaseModule extends _i926.FirebaseModule {}

class _$NetworkModule extends _i385.NetworkModule {}
