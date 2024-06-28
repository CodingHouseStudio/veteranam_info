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
import 'package:kozak/components/discounts/bloc/discount_watcher_bloc.dart'
    as _i27;
import 'package:kozak/components/employee_respond/bloc/employee_respond_bloc.dart'
    as _i22;
import 'package:kozak/components/feedback/bloc/feedback_bloc.dart' as _i29;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i21;
import 'package:kozak/components/information/bloc/information_watcher_bloc.dart'
    as _i23;
import 'package:kozak/components/investors/bloc/investors_watcher_bloc.dart'
    as _i14;
import 'package:kozak/components/login/bloc/login_bloc.dart' as _i31;
import 'package:kozak/components/my_discounts/bloc/my_discounts_watcher_bloc.dart'
    as _i33;
import 'package:kozak/components/my_story/bloc/my_story_watcher_bloc.dart'
    as _i25;
import 'package:kozak/components/sign_up/bloc/sign_up_bloc.dart' as _i30;
import 'package:kozak/components/story/bloc/story_watcher_bloc.dart' as _i17;
import 'package:kozak/components/story_add/bloc/story_add_bloc.dart' as _i26;
import 'package:kozak/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i20;
import 'package:kozak/shared/bloc/authentication/authentication_bloc.dart'
    as _i35;
import 'package:kozak/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i34;
import 'package:kozak/shared/bloc/report/report_bloc.dart' as _i28;
import 'package:kozak/shared/data_provider/cache_provider.dart' as _i3;
import 'package:kozak/shared/data_provider/firestore_provider.dart' as _i4;
import 'package:kozak/shared/data_provider/storage_provider.dart' as _i5;
import 'package:kozak/shared/repositories/app_authentication_repository.dart'
    as _i24;
import 'package:kozak/shared/repositories/authentication_repository.dart'
    as _i32;
import 'package:kozak/shared/repositories/discount_repository.dart' as _i11;
import 'package:kozak/shared/repositories/feedback_repository.dart' as _i19;
import 'package:kozak/shared/repositories/firebase_module.dart' as _i36;
import 'package:kozak/shared/repositories/home_repository.dart' as _i13;
import 'package:kozak/shared/repositories/information_repository.dart' as _i15;
import 'package:kozak/shared/repositories/investors_repository.dart' as _i12;
import 'package:kozak/shared/repositories/report_repository.dart' as _i18;
import 'package:kozak/shared/repositories/secure_storage_repository.dart'
    as _i10;
import 'package:kozak/shared/repositories/story_repository.dart' as _i16;
import 'package:kozak/shared/repositories/work_repository.dart' as _i9;
import 'package:kozak/shared/shared.dart' as _i8;

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
    gh.singleton<_i8.IWorkRepository>(() => _i9.WorkRepository());
    gh.lazySingleton<_i8.IStorage>(() => _i10.SecureStorageRepository());
    gh.singleton<_i8.IDiscountRepository>(() => _i11.DiscountRepository());
    gh.singleton<_i8.IInvestorsRepository>(() => _i12.InvestorsRepository());
    gh.singleton<_i8.IHomeRepository>(() => _i13.HomeRepository());
    gh.factory<_i14.InvestorsWatcherBloc>(() => _i14.InvestorsWatcherBloc(
        investorsRepository: gh<_i8.IInvestorsRepository>()));
    gh.singleton<_i8.IInformationRepository>(
        () => _i15.InformationRepository());
    gh.singleton<_i8.IStoryRepository>(() => _i16.StoryRepository());
    gh.factory<_i17.StoryWatcherBloc>(() =>
        _i17.StoryWatcherBloc(storyRepository: gh<_i8.IStoryRepository>()));
    gh.singleton<_i8.IReportRepository>(() => _i18.ReportRepository());
    gh.singleton<_i8.IFeedbackRepository>(() => _i19.FeedbackRepository());
    gh.factory<_i20.WorkEmployeeWatcherBloc>(() => _i20.WorkEmployeeWatcherBloc(
        workRepository: gh<_i8.IWorkRepository>()));
    gh.factory<_i21.HomeWatcherBloc>(
        () => _i21.HomeWatcherBloc(homeRepository: gh<_i8.IHomeRepository>()));
    gh.factory<_i22.EmployeeRespondBloc>(() => _i22.EmployeeRespondBloc(
        employeeRespondRepository: gh<_i8.IWorkRepository>()));
    gh.factory<_i23.InformationWatcherBloc>(() => _i23.InformationWatcherBloc(
        informationRepository: gh<_i8.IInformationRepository>()));
    gh.singleton<_i8.IAppAuthenticationRepository>(
        () => _i24.AppAuthenticationRepository(
              gh<_i8.IStorage>(),
              gh<_i6.FirebaseAuth>(),
              gh<_i7.GoogleSignIn>(),
              gh<_i8.CacheClient>(),
            ));
    gh.factory<_i25.MyStoryWatcherBloc>(() => _i25.MyStoryWatcherBloc(
          storyRepository: gh<_i8.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i26.StoryAddBloc>(() => _i26.StoryAddBloc(
          storyRepository: gh<_i8.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i27.DiscountWatcherBloc>(() => _i27.DiscountWatcherBloc(
        discountRepository: gh<_i8.IDiscountRepository>()));
    gh.factory<_i28.ReportBloc>(() => _i28.ReportBloc(
          reportRepository: gh<_i8.IReportRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i29.FeedbackBloc>(() => _i29.FeedbackBloc(
          feedbackRepository: gh<_i8.IFeedbackRepository>(),
          appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i30.SignUpBloc>(() => _i30.SignUpBloc(
        iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>()));
    gh.factory<_i31.LoginBloc>(() => _i31.LoginBloc(
        appAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>()));
    gh.singleton<_i32.AuthenticationRepository>(() =>
        _i32.AuthenticationRepository(gh<_i8.IAppAuthenticationRepository>()));
    gh.factory<_i33.MyDiscountsWatcherBloc>(() => _i33.MyDiscountsWatcherBloc(
          discountRepository: gh<_i8.IDiscountRepository>(),
          iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i34.AuthenticationServicesCubit>(() =>
        _i34.AuthenticationServicesCubit(
            authenticationRepository: gh<_i8.AuthenticationRepository>()));
    gh.singleton<_i35.AuthenticationBloc>(() => _i35.AuthenticationBloc(
        authenticationRepository: gh<_i8.AuthenticationRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i36.FirebaseModule {}
