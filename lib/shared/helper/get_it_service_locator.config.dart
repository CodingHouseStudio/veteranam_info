// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i21;
import 'package:kozak/components/information/bloc/information_watcher_bloc.dart'
    as _i22;
import 'package:kozak/components/investors/bloc/investors_watcher_bloc.dart'
    as _i15;
import 'package:kozak/components/login/bloc/login_bloc.dart' as _i28;
import 'package:kozak/components/sign_up/bloc/sign_up_bloc.dart' as _i26;
import 'package:kozak/components/story/bloc/story_watcher_bloc.dart' as _i18;
import 'package:kozak/components/story_add/bloc/story_add_bloc.dart' as _i25;
import 'package:kozak/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i20;
import 'package:kozak/shared/bloc/authentication/authentication_bloc.dart'
    as _i30;
import 'package:kozak/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i29;
import 'package:kozak/shared/bloc/feedback/feedback_bloc.dart' as _i23;
import 'package:kozak/shared/bloc/scroll/scroll_cubit.dart' as _i3;
import 'package:kozak/shared/data_provider/cache_provider.dart' as _i4;
import 'package:kozak/shared/data_provider/fake_provider.dart' as _i5;
import 'package:kozak/shared/data_provider/firestore_provider.dart' as _i6;
import 'package:kozak/shared/data_provider/storage_provider.dart' as _i7;
import 'package:kozak/shared/repositories/app_authentication_repository.dart'
    as _i24;
import 'package:kozak/shared/repositories/authentication_repository.dart'
    as _i27;
import 'package:kozak/shared/repositories/feedback_repository.dart' as _i19;
import 'package:kozak/shared/repositories/firebase_module.dart' as _i31;
import 'package:kozak/shared/repositories/home_repository.dart' as _i14;
import 'package:kozak/shared/repositories/information_repository.dart' as _i16;
import 'package:kozak/shared/repositories/investors_repository.dart' as _i13;
import 'package:kozak/shared/repositories/secure_storage_repository.dart'
    as _i12;
import 'package:kozak/shared/repositories/story_repository.dart' as _i17;
import 'package:kozak/shared/repositories/work_repository.dart' as _i11;
import 'package:kozak/shared/shared.dart' as _i10;

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
    gh.factory<_i3.ScrollCubit>(() => _i3.ScrollCubit());
    gh.factory<_i4.CacheClient>(() => _i4.CacheClient());
    gh.singleton<_i5.FakeClient>(() => _i5.FakeClient());
    gh.singleton<_i6.FirestoreService>(() => _i6.FirestoreService());
    gh.singleton<_i7.StorageService>(() => _i7.StorageService());
    gh.singleton<_i8.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i9.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i10.IWorkRepository>(() => _i11.WorkRepository());
    gh.lazySingleton<_i10.IStorage>(() => _i12.SecureStorageRepository());
    gh.singleton<_i10.IInvestorsRepository>(() => _i13.InvestorsRepository());
    gh.singleton<_i10.IHomeRepository>(() => _i14.HomeRepository());
    gh.factory<_i15.InvestorsWatcherBloc>(() => _i15.InvestorsWatcherBloc(
        investorsRepository: gh<_i10.IInvestorsRepository>()));
    gh.singleton<_i10.IInformationRepository>(
        () => _i16.InformationRepository());
    gh.singleton<_i10.IStoryRepository>(() => _i17.StoryRepository());
    gh.factory<_i18.StoryWatcherBloc>(() =>
        _i18.StoryWatcherBloc(storyRepository: gh<_i10.IStoryRepository>()));
    gh.singleton<_i10.IFeedbackRepository>(() => _i19.FeedbackRepository());
    gh.factory<_i20.WorkEmployeeWatcherBloc>(() => _i20.WorkEmployeeWatcherBloc(
        workRepository: gh<_i10.IWorkRepository>()));
    gh.factory<_i21.HomeWatcherBloc>(
        () => _i21.HomeWatcherBloc(homeRepository: gh<_i10.IHomeRepository>()));
    gh.factory<_i22.InformationWatcherBloc>(() => _i22.InformationWatcherBloc(
        informationRepository: gh<_i10.IInformationRepository>()));
    gh.factory<_i23.FeedbackBloc>(() =>
        _i23.FeedbackBloc(feedbackRepository: gh<_i10.IFeedbackRepository>()));
    gh.singleton<_i10.IAppAuthenticationRepository>(
        () => _i24.AppAuthenticationRepository(
              gh<_i10.IStorage>(),
              gh<_i8.FirebaseAuth>(),
              gh<_i9.GoogleSignIn>(),
              gh<_i10.CacheClient>(),
            ));
    gh.factory<_i25.StoryAddBloc>(() => _i25.StoryAddBloc(
          storyRepository: gh<_i10.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i26.SignUpBloc>(() => _i26.SignUpBloc(
        iAppAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>()));
    gh.singleton<_i27.AuthenticationRepository>(() =>
        _i27.AuthenticationRepository(gh<_i10.IAppAuthenticationRepository>()));
    gh.factory<_i28.LoginBloc>(() => _i28.LoginBloc(
        authenticationRepository: gh<_i10.AuthenticationRepository>()));
    gh.factory<_i29.AuthenticationServicesCubit>(() =>
        _i29.AuthenticationServicesCubit(
            authenticationRepository: gh<_i10.AuthenticationRepository>()));
    gh.singleton<_i30.AuthenticationBloc>(() => _i30.AuthenticationBloc(
        authenticationRepository: gh<_i10.AuthenticationRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i31.FirebaseModule {}
