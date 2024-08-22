// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart'
    as _i334;
import 'package:veteranam/components/discounts/bloc/advanced_filter/advanced_filter_mob_cubit.dart'
    as _i189;
import 'package:veteranam/components/discounts/bloc/link/discount_link_cubit.dart'
    as _i227;
import 'package:veteranam/components/discounts/bloc/link/discount_link_form_bloc.dart'
    as _i372;
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart'
    as _i1006;
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
import 'package:veteranam/components/privacy_policy/bloc/privacy_policy_markdown_cubit.dart'
    as _i686;
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart' as _i785;
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart'
    as _i763;
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart'
    as _i716;
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i557;
import 'package:veteranam/shared/bloc/authentication/authentication_bloc.dart'
    as _i570;
import 'package:veteranam/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i209;
import 'package:veteranam/shared/bloc/mob_feedback/mob_feedback_bloc.dart'
    as _i872;
import 'package:veteranam/shared/bloc/network/network_cubit.dart' as _i891;
import 'package:veteranam/shared/bloc/report/report_bloc.dart' as _i765;
import 'package:veteranam/shared/bloc/url/url_cubit.dart' as _i319;
import 'package:veteranam/shared/data_provider/cache_provider.dart' as _i37;
import 'package:veteranam/shared/data_provider/firestore_provider.dart'
    as _i1033;
import 'package:veteranam/shared/data_provider/storage_provider.dart' as _i99;
import 'package:veteranam/shared/repositories/app_authentication_repository.dart'
    as _i99;
import 'package:veteranam/shared/repositories/app_nerwork_repository.dart'
    as _i336;
import 'package:veteranam/shared/repositories/authentication_repository.dart'
    as _i208;
import 'package:veteranam/shared/repositories/discount_repository.dart'
    as _i452;
import 'package:veteranam/shared/repositories/faq_repository.dart' as _i1007;
import 'package:veteranam/shared/repositories/feedback_repository.dart'
    as _i361;
import 'package:veteranam/shared/repositories/firebase_module.dart' as _i926;
import 'package:veteranam/shared/repositories/information_repository.dart'
    as _i154;
import 'package:veteranam/shared/repositories/investors_repository.dart'
    as _i994;
import 'package:veteranam/shared/repositories/network_module.dart' as _i385;
import 'package:veteranam/shared/repositories/network_repository.dart' as _i997;
import 'package:veteranam/shared/repositories/report_repository.dart' as _i205;
import 'package:veteranam/shared/repositories/secure_storage_repository.dart'
    as _i949;
import 'package:veteranam/shared/repositories/story_repository.dart' as _i801;
import 'package:veteranam/shared/repositories/url_repository.dart' as _i929;
import 'package:veteranam/shared/repositories/work_repository.dart' as _i76;
import 'package:veteranam/shared/shared.dart' as _i1001;

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
    final networkModule = _$NetworkModule();
    final firebaseModule = _$FirebaseModule();
    gh.singleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.factory<_i37.CacheClient>(() => _i37.CacheClient());
    gh.singleton<_i1001.IAppNetworkRepository>(() => _i336.AppNetworkRepository(
          gh<_i895.Connectivity>(),
          gh<_i1001.CacheClient>(),
        ));
    gh.singleton<_i1033.FirestoreService>(
        () => _i1033.FirestoreService(gh<_i1001.IAppNetworkRepository>()));
    gh.factory<_i189.AdvancedFilterMobCubit>(
        () => _i189.AdvancedFilterMobCubit());
    gh.singleton<_i99.StorageService>(() => _i99.StorageService());
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i1001.IDiscountRepository>(
      () => _i452.DiscountRepository(),
      signalsReady: true,
    );
    gh.singleton<_i1001.IFaqRepository>(() => _i1007.FaqRepository());
    gh.singleton<_i1001.IFeedbackRepository>(() => _i361.FeedbackRepository());
    gh.factory<_i522.HomeWatcherBloc>(() =>
        _i522.HomeWatcherBloc(faqRepository: gh<_i1001.IFaqRepository>()));
    gh.factory<_i687.MobFaqWatcherBloc>(() =>
        _i687.MobFaqWatcherBloc(faqRepository: gh<_i1001.IFaqRepository>()));
    gh.lazySingleton<_i1001.IUrlRepository>(() => _i929.UrlRepository());
    gh.singleton<_i1001.IStorage>(() => _i949.SecureStorageRepository());
    gh.singleton<_i1001.IInvestorsRepository>(
      () => _i994.InvestorsRepository(),
      signalsReady: true,
    );
    gh.singleton<_i1001.IAppAuthenticationRepository>(
        () => _i99.AppAuthenticationRepository(
              gh<_i1001.IStorage>(),
              gh<_i59.FirebaseAuth>(),
              gh<_i116.GoogleSignIn>(),
              gh<_i1001.CacheClient>(),
            ));
    gh.factory<_i1025.LoginBloc>(
      () => _i1025.LoginBloc(
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>()),
      registerFor: {_development},
    );
    gh.singleton<_i1001.IReportRepository>(
      () => _i205.ReportRepository(),
      signalsReady: true,
    );
    gh.factory<_i319.UrlCubit>(
        () => _i319.UrlCubit(urlRepository: gh<_i1001.IUrlRepository>()));
    gh.factory<_i227.DiscountLinkCubit>(() => _i227.DiscountLinkCubit(
          discountRepository: gh<_i1001.IDiscountRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i372.DiscountLinkFormBloc>(() => _i372.DiscountLinkFormBloc(
          discountRepository: gh<_i1001.IDiscountRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i334.DiscountCardWatcherBloc>(() =>
        _i334.DiscountCardWatcherBloc(
            discountRepository: gh<_i1001.IDiscountRepository>()));
    gh.singleton<_i1001.IStoryRepository>(
      () => _i801.StoryRepository(),
      registerFor: {_development},
    );
    gh.factory<_i1006.DiscountWatcherBloc>(() => _i1006.DiscountWatcherBloc(
          discountRepository: gh<_i1001.IDiscountRepository>(),
          reportRepository: gh<_i1001.IReportRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i609.InvestorsWatcherBloc>(() => _i609.InvestorsWatcherBloc(
          investorsRepository: gh<_i1001.IInvestorsRepository>(),
          reportRepository: gh<_i1001.IReportRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i1032.MyDiscountsWatcherBloc>(
      () => _i1032.MyDiscountsWatcherBloc(
        discountRepository: gh<_i1001.IDiscountRepository>(),
        iAppAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_development},
    );
    gh.factory<_i1026.FeedbackBloc>(() => _i1026.FeedbackBloc(
          feedbackRepository: gh<_i1001.IFeedbackRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i872.MobFeedbackBloc>(() => _i872.MobFeedbackBloc(
          feedbackRepository: gh<_i1001.IFeedbackRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.singleton<_i1001.IInformationRepository>(
      () => _i154.InformationRepository(),
      registerFor: {_development},
    );
    gh.factory<_i763.StoryWatcherBloc>(
      () => _i763.StoryWatcherBloc(
          storyRepository: gh<_i1001.IStoryRepository>()),
      registerFor: {_development},
    );
    gh.singleton<_i208.AuthenticationRepository>(
      () => _i208.AuthenticationRepository(
          gh<_i1001.IAppAuthenticationRepository>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i785.SignUpBloc>(
      () => _i785.SignUpBloc(
          iAppAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>()),
      registerFor: {_development},
    );
    gh.factory<_i686.PrivacyPolicyMarkdownCubit>(() =>
        _i686.PrivacyPolicyMarkdownCubit(
            appAuthenticationRepository:
                gh<_i1001.IAppAuthenticationRepository>()));
    gh.singleton<_i1001.IWorkRepository>(
      () => _i76.WorkRepository(),
      registerFor: {_development},
    );
    gh.factory<_i688.NewsCardWatcherBloc>(
      () => _i688.NewsCardWatcherBloc(
          informationRepository: gh<_i1001.IInformationRepository>()),
      registerFor: {_development},
    );
    gh.factory<_i209.AuthenticationServicesCubit>(() =>
        _i209.AuthenticationServicesCubit(
            authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.singleton<_i570.AuthenticationBloc>(() => _i570.AuthenticationBloc(
        authenticationRepository: gh<_i1001.AuthenticationRepository>()));
    gh.factory<_i765.ReportBloc>(() => _i765.ReportBloc(
          reportRepository: gh<_i1001.IReportRepository>(),
          appAuthenticationRepository:
              gh<_i1001.IAppAuthenticationRepository>(),
        ));
    gh.singleton<_i997.NetworkRepository>(
      () => _i997.NetworkRepository(gh<_i1001.IAppNetworkRepository>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i922.MyStoryWatcherBloc>(
      () => _i922.MyStoryWatcherBloc(
        storyRepository: gh<_i1001.IStoryRepository>(),
        iAppAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_development},
    );
    gh.factory<_i716.StoryAddBloc>(
      () => _i716.StoryAddBloc(
        storyRepository: gh<_i1001.IStoryRepository>(),
        iAppAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_development},
    );
    gh.factory<_i408.InformationWatcherBloc>(
      () => _i408.InformationWatcherBloc(
        informationRepository: gh<_i1001.IInformationRepository>(),
        reportRepository: gh<_i1001.IReportRepository>(),
        appAuthenticationRepository: gh<_i1001.IAppAuthenticationRepository>(),
      ),
      registerFor: {_development},
    );
    gh.factory<_i557.WorkEmployeeWatcherBloc>(
      () => _i557.WorkEmployeeWatcherBloc(
          workRepository: gh<_i1001.IWorkRepository>()),
      registerFor: {_development},
    );
    gh.factory<_i675.EmployeeRespondBloc>(
      () => _i675.EmployeeRespondBloc(
          employeeRespondRepository: gh<_i1001.IWorkRepository>()),
      registerFor: {_development},
    );
    gh.singleton<_i891.NetworkCubit>(() =>
        _i891.NetworkCubit(networkRepository: gh<_i1001.NetworkRepository>()));
    return this;
  }
}

class _$NetworkModule extends _i385.NetworkModule {}

class _$FirebaseModule extends _i926.FirebaseModule {}
