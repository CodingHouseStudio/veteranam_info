// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i17;
import 'package:kozak/components/information/bloc/information_watcher_bloc.dart'
    as _i18;
import 'package:kozak/components/investors/bloc/investors_watcher_bloc.dart'
    as _i13;
import 'package:kozak/components/login/bloc/login_bloc.dart' as _i23;
import 'package:kozak/components/sign_up/bloc/sign_up_bloc.dart' as _i21;
import 'package:kozak/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i16;
import 'package:kozak/shared/bloc/authentication/authentication_bloc.dart'
    as _i25;
import 'package:kozak/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i24;
import 'package:kozak/shared/bloc/feedback/feedback_bloc.dart' as _i19;
import 'package:kozak/shared/bloc/filter/filter_cubit.dart' as _i3;
import 'package:kozak/shared/data_provider/cache_provider.dart' as _i4;
import 'package:kozak/shared/data_provider/fake_provider.dart' as _i5;
import 'package:kozak/shared/data_provider/firestore_provider.dart' as _i6;
import 'package:kozak/shared/repositories/app_authentication_repository.dart'
    as _i20;
import 'package:kozak/shared/repositories/authentication_repository.dart'
    as _i22;
import 'package:kozak/shared/repositories/feedback_repository.dart' as _i15;
import 'package:kozak/shared/repositories/firebase_module.dart' as _i26;
import 'package:kozak/shared/repositories/home_repository.dart' as _i12;
import 'package:kozak/shared/repositories/information_repository.dart' as _i14;
import 'package:kozak/shared/repositories/investors_repository.dart' as _i11;
import 'package:kozak/shared/repositories/secure_storage_repository.dart'
    as _i10;
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
    gh.factory<_i3.FilterCubit>(() => _i3.FilterCubit());
    gh.factory<_i4.CacheClient>(() => _i4.CacheClient());
    gh.singleton<_i5.FakeClient>(() => _i5.FakeClient());
    gh.singleton<_i6.FirestoreService>(() => _i6.FirestoreService());
    gh.singleton<_i7.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i8.IWorkRepository>(() => _i9.WorkRepository());
    gh.lazySingleton<_i8.IStorage>(() => _i10.SecureStorageRepository());
    gh.singleton<_i8.IInvestorsRepository>(() => _i11.InvestorsRepository());
    gh.singleton<_i8.IHomeRepository>(() => _i12.HomeRepository());
    gh.factory<_i13.InvestorsWatcherBloc>(() => _i13.InvestorsWatcherBloc(
        investorsRepository: gh<_i8.IInvestorsRepository>()));
    gh.singleton<_i8.IInformationRepository>(
        () => _i14.InformationRepository());
    gh.singleton<_i8.IFeedbackRepository>(() => _i15.FeedbackRepository());
    gh.factory<_i16.WorkEmployeeWatcherBloc>(() => _i16.WorkEmployeeWatcherBloc(
        workRepository: gh<_i8.IWorkRepository>()));
    gh.factory<_i17.HomeWatcherBloc>(
        () => _i17.HomeWatcherBloc(homeRepository: gh<_i8.IHomeRepository>()));
    gh.factory<_i18.InformationWatcherBloc>(() => _i18.InformationWatcherBloc(
        informationRepository: gh<_i8.IInformationRepository>()));
    gh.factory<_i19.FeedbackBloc>(() =>
        _i19.FeedbackBloc(feedbackRepository: gh<_i8.IFeedbackRepository>()));
    gh.singleton<_i8.IAppAuthenticationRepository>(
        () => _i20.AppAuthenticationRepository(
              gh<_i8.IStorage>(),
              gh<_i7.GoogleSignIn>(),
              gh<_i8.CacheClient>(),
            ));
    gh.factory<_i21.SignUpBloc>(() => _i21.SignUpBloc(
        iAppAuthenticationRepository: gh<_i8.IAppAuthenticationRepository>()));
    gh.singleton<_i22.AuthenticationRepository>(() =>
        _i22.AuthenticationRepository(gh<_i8.IAppAuthenticationRepository>()));
    gh.factory<_i23.LoginBloc>(() => _i23.LoginBloc(
        authenticationRepository: gh<_i8.AuthenticationRepository>()));
    gh.factory<_i24.AuthenticationServicesCubit>(() =>
        _i24.AuthenticationServicesCubit(
            authenticationRepository: gh<_i8.AuthenticationRepository>()));
    gh.singleton<_i25.AuthenticationBloc>(() => _i25.AuthenticationBloc(
        authenticationRepository: gh<_i8.AuthenticationRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i26.FirebaseModule {}
