// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i15;
import 'package:kozak/components/information/bloc/information_watcher_bloc.dart'
    as _i16;
import 'package:kozak/components/login/bloc/login_bloc.dart' as _i22;
import 'package:kozak/components/sign_up/bloc/sign_up_bloc.dart' as _i19;
import 'package:kozak/shared/bloc/authentication/authentication_bloc.dart'
    as _i23;
import 'package:kozak/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i21;
import 'package:kozak/shared/bloc/feedback/feedback_bloc.dart' as _i17;
import 'package:kozak/shared/bloc/filter/filter_cubit.dart' as _i4;
import 'package:kozak/shared/bloc/language/language_cubit.dart' as _i9;
import 'package:kozak/shared/data_provider/cache_provider.dart' as _i3;
import 'package:kozak/shared/data_provider/fake_provider.dart' as _i5;
import 'package:kozak/shared/data_provider/firestore_provider.dart' as _i6;
import 'package:kozak/shared/repositories/app_authentication_repository.dart'
    as _i18;
import 'package:kozak/shared/repositories/authentication_repository.dart'
    as _i20;
import 'package:kozak/shared/repositories/feedback_repository.dart' as _i14;
import 'package:kozak/shared/repositories/firebase_module.dart' as _i24;
import 'package:kozak/shared/repositories/home_repository.dart' as _i12;
import 'package:kozak/shared/repositories/information_repository.dart' as _i13;
import 'package:kozak/shared/repositories/secure_storage_repository.dart'
    as _i11;
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
    gh.factory<_i3.CacheClient>(() => _i3.CacheClient());
    gh.factory<_i4.FilterCubit>(() => _i4.FilterCubit());
    gh.singleton<_i5.FakeClient>(() => _i5.FakeClient());
    gh.singleton<_i6.FirestoreService>(() => _i6.FirestoreService());
    gh.singleton<_i7.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i8.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i9.LanguageCubit>(() => _i9.LanguageCubit());
    gh.lazySingleton<_i10.IStorage>(() => _i11.SecureStorageRepository());
    gh.singleton<_i10.IHomeRepository>(() => _i12.HomeRepository());
    gh.singleton<_i10.IInformationRepository>(
        () => _i13.InformationRepository());
    gh.singleton<_i10.IFeedbackRepository>(() => _i14.FeedbackRepository());
    gh.factory<_i15.HomeWatcherBloc>(
        () => _i15.HomeWatcherBloc(homeRepository: gh<_i10.IHomeRepository>()));
    gh.factory<_i16.InformationWatcherBloc>(() => _i16.InformationWatcherBloc(
        informationRepository: gh<_i10.IInformationRepository>()));
    gh.factory<_i17.FeedbackBloc>(() =>
        _i17.FeedbackBloc(feedbackRepository: gh<_i10.IFeedbackRepository>()));
    gh.singleton<_i10.IAppAuthenticationRepository>(
        () => _i18.AppAuthenticationRepository(
              gh<_i10.IStorage>(),
              gh<_i7.FirebaseAuth>(),
              gh<_i8.GoogleSignIn>(),
              gh<_i10.CacheClient>(),
            ));
    gh.factory<_i19.SignUpBloc>(() => _i19.SignUpBloc(
        iAppAuthenticationRepository: gh<_i10.IAppAuthenticationRepository>()));
    gh.singleton<_i20.AuthenticationRepository>(() =>
        _i20.AuthenticationRepository(gh<_i10.IAppAuthenticationRepository>()));
    gh.factory<_i21.AuthenticationServicesCubit>(() =>
        _i21.AuthenticationServicesCubit(
            authenticationRepository: gh<_i10.AuthenticationRepository>()));
    gh.factory<_i22.LoginBloc>(() => _i22.LoginBloc(
        authenticationRepository: gh<_i10.AuthenticationRepository>()));
    gh.singleton<_i23.AuthenticationBloc>(() => _i23.AuthenticationBloc(
        authenticationRepository: gh<_i10.AuthenticationRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i24.FirebaseModule {}
