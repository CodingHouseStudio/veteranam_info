// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_bloc.dart'
    as _i27;
import 'package:veteranam/components/discounts/bloc/link/discount_link_cubit.dart'
    as _i25;
import 'package:veteranam/components/discounts/bloc/link/discount_link_form_bloc.dart'
    as _i26;
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart'
    as _i28;
import 'package:veteranam/components/employee_respond/bloc/employee_respond_bloc.dart'
    as _i37;
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart' as _i30;
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart' as _i22;
import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart'
    as _i34;
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart'
    as _i29;
import 'package:veteranam/components/login/bloc/login_bloc.dart' as _i32;
import 'package:veteranam/components/my_discounts/bloc/my_discounts_watcher_bloc.dart'
    as _i38;
import 'package:veteranam/components/my_story/bloc/my_story_watcher_bloc.dart'
    as _i35;
import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart'
    as _i24;
import 'package:veteranam/components/privacy_policy/bloc/privacy_policy_markdown_cubit.dart'
    as _i33;
import 'package:veteranam/components/sign_up/bloc/sign_up_bloc.dart' as _i18;
import 'package:veteranam/components/story/bloc/story_watcher_bloc.dart'
    as _i21;
import 'package:veteranam/components/story_add/bloc/story_add_bloc.dart'
    as _i36;
import 'package:veteranam/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i39;
import 'package:veteranam/shared/bloc/authentication/authentication_bloc.dart'
    as _i41;
import 'package:veteranam/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i40;
import 'package:veteranam/shared/bloc/report/report_bloc.dart' as _i42;
import 'package:veteranam/shared/bloc/url/url_cubit.dart' as _i23;
import 'package:veteranam/shared/data_provider/cache_provider.dart' as _i3;
import 'package:veteranam/shared/data_provider/firestore_provider.dart' as _i4;
import 'package:veteranam/shared/data_provider/storage_provider.dart' as _i5;
import 'package:veteranam/shared/repositories/app_authentication_repository.dart'
    as _i15;
import 'package:veteranam/shared/repositories/authentication_repository.dart'
    as _i31;
import 'package:veteranam/shared/repositories/discount_repository.dart' as _i9;
import 'package:veteranam/shared/repositories/feedback_repository.dart' as _i10;
import 'package:veteranam/shared/repositories/firebase_module.dart' as _i43;
import 'package:veteranam/shared/repositories/home_repository.dart' as _i14;
import 'package:veteranam/shared/repositories/information_repository.dart'
    as _i19;
import 'package:veteranam/shared/repositories/investors_repository.dart'
    as _i13;
import 'package:veteranam/shared/repositories/report_repository.dart' as _i20;
import 'package:veteranam/shared/repositories/secure_storage_repository.dart'
    as _i12;
import 'package:veteranam/shared/repositories/story_repository.dart' as _i16;
import 'package:veteranam/shared/repositories/url_repository.dart' as _i11;
import 'package:veteranam/shared/repositories/work_repository.dart' as _i17;
import 'package:veteranam/shared/shared.dart' as _i8;

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
    gh.factory<_i3.CacheClient>(() => _i3.CacheClient());
    gh.singleton<_i4.FirestoreService>(() => _i4.FirestoreService());
    gh.singleton<_i5.StorageService>(() => _i5.StorageService());
    gh.singleton<_i6.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i7.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i8.IDiscountRepository>(() => _i9.DiscountRepository());
    gh.singleton<_i8.IFeedbackRepository>(() => _i10.FeedbackRepository());
    gh.singleton<_i8.IUrlRepository>(() => _i11.UrlRepository());
    gh.lazySingleton<_i8.IStorage>(() => _i12.SecureStorageRepository());
    gh.singleton<_i8.IInvestorsRepository>(() => _i13.InvestorsRepository());
    gh.singleton<_i8.IHomeRepository>(() => _i14.HomeRepository());
    gh.singleton<_i8.IAppAuthenticationRepository>(
        () => _i15.AppAuthenticationRepository(
              gh<_i8.IStorage>(),
              gh<_i6.FirebaseAuth>(),
              gh<_i7.GoogleSignIn>(),
              gh<_i8.CacheClient>(),
            ));
    gh.lazySingleton<_i8.IStoryRepository>(() => _i16.StoryRepository());
    gh.lazySingleton<_i8.IWorkRepository>(() => _i17.WorkRepository());
    gh.factory<_i18.SignUpBloc>(() => _i18.SignUpBloc(
        iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>()));
    gh.lazySingleton<_i8.IInformationRepository>(
        () => _i19.InformationRepository());
    gh.lazySingleton<_i8.IReportRepository>(() => _i20.ReportRepository());
    gh.factory<_i21.StoryWatcherBloc>(() =>
        _i21.StoryWatcherBloc(storyRepository: gh<_i8.IStoryRepository>()));
    gh.factory<_i22.HomeWatcherBloc>(
        () => _i22.HomeWatcherBloc(homeRepository: gh<_i8.IHomeRepository>()));
    gh.factory<_i23.UrlCubit>(
        () => _i23.UrlCubit(urlRepository: gh<_i8.IUrlRepository>()));
    gh.factory<_i24.NewsCardWatcherBloc>(() => _i24.NewsCardWatcherBloc(
        informationRepository: gh<_i8.IInformationRepository>()));
    gh.factory<_i25.DiscountLinkCubit>(() => _i25.DiscountLinkCubit(
          discountRepository: gh<_i8.IDiscountRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i26.DiscountLinkFormBloc>(() => _i26.DiscountLinkFormBloc(
          discountRepository: gh<_i8.IDiscountRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i27.DiscountCardWatcherBloc>(() => _i27.DiscountCardWatcherBloc(
        discountRepository: gh<_i8.IDiscountRepository>()));
    gh.factory<_i28.DiscountWatcherBloc>(() => _i28.DiscountWatcherBloc(
          discountRepository: gh<_i8.IDiscountRepository>(),
          reportRepository: gh<_i8.IReportRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i29.InvestorsWatcherBloc>(() => _i29.InvestorsWatcherBloc(
          investorsRepository: gh<_i8.IInvestorsRepository>(),
          reportRepository: gh<_i8.IReportRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i30.FeedbackBloc>(() => _i30.FeedbackBloc(
          feedbackRepository: gh<_i8.IFeedbackRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.singleton<_i31.AuthenticationRepository>(() =>
        _i31.AuthenticationRepository(gh<_i8.IAppAuthenticationRepository>()));
    gh.factory<_i32.LoginBloc>(() => _i32.LoginBloc(
        appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>()));
    gh.factory<_i33.PrivacyPolicyMarkdownCubit>(() =>
        _i33.PrivacyPolicyMarkdownCubit(
            appAuthenticationRepository:
                gh<_i8.IAppAuthenticationRepository>()));
    gh.factory<_i34.InformationWatcherBloc>(() => _i34.InformationWatcherBloc(
          informationRepository: gh<_i8.IInformationRepository>(),
          reportRepository: gh<_i8.IReportRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i35.MyStoryWatcherBloc>(() => _i35.MyStoryWatcherBloc(
          storyRepository: gh<_i8.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i36.StoryAddBloc>(() => _i36.StoryAddBloc(
          storyRepository: gh<_i8.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i37.EmployeeRespondBloc>(() => _i37.EmployeeRespondBloc(
        employeeRespondRepository: gh<_i8.IWorkRepository>()));
    gh.factory<_i38.MyDiscountsWatcherBloc>(() => _i38.MyDiscountsWatcherBloc(
          discountRepository: gh<_i8.IDiscountRepository>(),
          iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i39.WorkEmployeeWatcherBloc>(() => _i39.WorkEmployeeWatcherBloc(
        workRepository: gh<_i8.IWorkRepository>()));
    gh.factory<_i40.AuthenticationServicesCubit>(() =>
        _i40.AuthenticationServicesCubit(
            authenticationRepository: gh<_i8.AuthenticationRepository>()));
    gh.singleton<_i41.AuthenticationBloc>(() => _i41.AuthenticationBloc(
        authenticationRepository: gh<_i8.AuthenticationRepository>()));
    gh.factory<_i42.ReportBloc>(() => _i42.ReportBloc(
          reportRepository: gh<_i8.IReportRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    return this;
  }
}

class _$FirebaseModule extends _i43.FirebaseModule {}
