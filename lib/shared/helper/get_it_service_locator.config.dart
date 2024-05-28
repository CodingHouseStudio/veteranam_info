// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kozak/components/employee_respond/bloc/employee_respond_bloc.dart'
    as _i23;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i22;
import 'package:kozak/components/information/bloc/information_watcher_bloc.dart'
    as _i24;
import 'package:kozak/components/investors/bloc/investors_watcher_bloc.dart'
    as _i16;
import 'package:kozak/components/login/bloc/login_bloc.dart' as _i30;
import 'package:kozak/components/sign_up/bloc/sign_up_bloc.dart' as _i28;
import 'package:kozak/components/story/bloc/story_watcher_bloc.dart' as _i19;
import 'package:kozak/components/story_add/bloc/story_add_bloc.dart' as _i27;
import 'package:kozak/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i21;
import 'package:kozak/shared/bloc/authentication/authentication_bloc.dart'
    as _i32;
import 'package:kozak/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i31;
import 'package:kozak/shared/bloc/feedback/feedback_bloc.dart' as _i25;
import 'package:kozak/shared/bloc/filter/filter_cubit.dart' as _i3;
import 'package:kozak/shared/bloc/scroll/scroll_cubit.dart' as _i4;
import 'package:kozak/shared/data_provider/cache_provider.dart' as _i5;
import 'package:kozak/shared/data_provider/fake_provider.dart' as _i6;
import 'package:kozak/shared/data_provider/firestore_provider.dart' as _i7;
import 'package:kozak/shared/data_provider/storage_provider.dart' as _i8;
import 'package:kozak/shared/repositories/app_authentication_repository.dart'
    as _i26;
import 'package:kozak/shared/repositories/authentication_repository.dart'
    as _i29;
import 'package:kozak/shared/repositories/feedback_repository.dart' as _i20;
import 'package:kozak/shared/repositories/firebase_module.dart' as _i33;
import 'package:kozak/shared/repositories/home_repository.dart' as _i15;
import 'package:kozak/shared/repositories/information_repository.dart' as _i17;
import 'package:kozak/shared/repositories/investors_repository.dart' as _i14;
import 'package:kozak/shared/repositories/secure_storage_repository.dart'
    as _i13;
import 'package:kozak/shared/repositories/story_repository.dart' as _i18;
import 'package:kozak/shared/repositories/work_repository.dart' as _i12;
import 'package:kozak/shared/shared.dart' as _i11;

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
    gh.factory<_i3.FilterCubit>(() => _i3.FilterCubit());
    gh.factory<_i4.ScrollCubit>(() => _i4.ScrollCubit());
    gh.factory<_i5.CacheClient>(() => _i5.CacheClient());
    gh.singleton<_i6.FakeClient>(() => _i6.FakeClient());
    gh.singleton<_i7.FirestoreService>(() => _i7.FirestoreService());
    gh.singleton<_i8.StorageService>(() => _i8.StorageService());
    gh.singleton<_i9.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i10.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i11.IWorkRepository>(() => _i12.WorkRepository());
    gh.lazySingleton<_i11.IStorage>(() => _i13.SecureStorageRepository());
    gh.singleton<_i11.IInvestorsRepository>(() => _i14.InvestorsRepository());
    gh.singleton<_i11.IHomeRepository>(() => _i15.HomeRepository());
    gh.factory<_i16.InvestorsWatcherBloc>(() => _i16.InvestorsWatcherBloc(
        investorsRepository: gh<_i11.IInvestorsRepository>()));
    gh.singleton<_i11.IInformationRepository>(
        () => _i17.InformationRepository());
    gh.singleton<_i11.IStoryRepository>(() => _i18.StoryRepository());
    gh.factory<_i19.StoryWatcherBloc>(() =>
        _i19.StoryWatcherBloc(storyRepository: gh<_i11.IStoryRepository>()));
    gh.singleton<_i11.IFeedbackRepository>(() => _i20.FeedbackRepository());
    gh.factory<_i21.WorkEmployeeWatcherBloc>(() => _i21.WorkEmployeeWatcherBloc(
        workRepository: gh<_i11.IWorkRepository>()));
    gh.factory<_i22.HomeWatcherBloc>(
        () => _i22.HomeWatcherBloc(homeRepository: gh<_i11.IHomeRepository>()));
    gh.factory<_i23.EmployeeRespondBloc>(() => _i23.EmployeeRespondBloc(
        employeeRespondRepository: gh<_i11.IWorkRepository>()));
    gh.factory<_i24.InformationWatcherBloc>(() => _i24.InformationWatcherBloc(
        informationRepository: gh<_i11.IInformationRepository>()));
    gh.factory<_i25.FeedbackBloc>(() =>
        _i25.FeedbackBloc(feedbackRepository: gh<_i11.IFeedbackRepository>()));
    gh.singleton<_i11.IAppAuthenticationRepository>(
        () => _i26.AppAuthenticationRepository(
              gh<_i11.IStorage>(),
              gh<_i9.FirebaseAuth>(),
              gh<_i10.GoogleSignIn>(),
              gh<_i11.CacheClient>(),
            ));
    gh.factory<_i27.StoryAddBloc>(() => _i27.StoryAddBloc(
          storyRepository: gh<_i11.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i11.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i28.SignUpBloc>(() => _i28.SignUpBloc(
        iAppAuthenticationRepository: gh<_i11.IAppAuthenticationRepository>()));
    gh.singleton<_i29.AuthenticationRepository>(() =>
        _i29.AuthenticationRepository(gh<_i11.IAppAuthenticationRepository>()));
    gh.factory<_i30.LoginBloc>(() => _i30.LoginBloc(
        authenticationRepository: gh<_i11.AuthenticationRepository>()));
    gh.factory<_i31.AuthenticationServicesCubit>(() =>
        _i31.AuthenticationServicesCubit(
            authenticationRepository: gh<_i11.AuthenticationRepository>()));
    gh.singleton<_i32.AuthenticationBloc>(() => _i32.AuthenticationBloc(
        authenticationRepository: gh<_i11.AuthenticationRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i33.FirebaseModule {}
