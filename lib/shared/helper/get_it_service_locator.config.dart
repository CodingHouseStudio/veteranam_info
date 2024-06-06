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
import 'package:kozak/components/discounts/bloc/discount_watcher_bloc.dart'
    as _i27;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i22;
import 'package:kozak/components/information/bloc/information_watcher_bloc.dart'
    as _i23;
import 'package:kozak/components/investors/bloc/investors_watcher_bloc.dart'
    as _i15;
import 'package:kozak/components/login/bloc/login_bloc.dart' as _i32;
import 'package:kozak/components/my_discounts/bloc/my_discounts_watcher_bloc.dart'
    as _i31;
import 'package:kozak/components/my_story/bloc/my_story_watcher_bloc.dart'
    as _i25;
import 'package:kozak/components/sign_up/bloc/sign_up_bloc.dart' as _i29;
import 'package:kozak/components/story/bloc/story_watcher_bloc.dart' as _i18;
import 'package:kozak/components/story_add/bloc/story_add_bloc.dart' as _i26;
import 'package:kozak/components/work_employee/bloc/work_employee_watcher_bloc.dart'
    as _i21;
import 'package:kozak/shared/bloc/authentication/authentication_bloc.dart'
    as _i34;
import 'package:kozak/shared/bloc/authentication_services/authentication_services_cubit.dart'
    as _i33;
import 'package:kozak/shared/bloc/feedback/feedback_bloc.dart' as _i28;
import 'package:kozak/shared/data_provider/cache_provider.dart' as _i3;
import 'package:kozak/shared/data_provider/fake_provider.dart' as _i4;
import 'package:kozak/shared/data_provider/firestore_provider.dart' as _i5;
import 'package:kozak/shared/data_provider/storage_provider.dart' as _i6;
import 'package:kozak/shared/repositories/app_authentication_repository.dart'
    as _i24;
import 'package:kozak/shared/repositories/authentication_repository.dart'
    as _i30;
import 'package:kozak/shared/repositories/discount_repository.dart' as _i12;
import 'package:kozak/shared/repositories/feedback_repository.dart' as _i20;
import 'package:kozak/shared/repositories/firebase_module.dart' as _i35;
import 'package:kozak/shared/repositories/home_repository.dart' as _i14;
import 'package:kozak/shared/repositories/information_repository.dart' as _i16;
import 'package:kozak/shared/repositories/investors_repository.dart' as _i13;
import 'package:kozak/shared/repositories/secure_storage_repository.dart'
    as _i11;
import 'package:kozak/shared/repositories/story_repository.dart' as _i17;
import 'package:kozak/shared/repositories/tags_repository.dart' as _i19;
import 'package:kozak/shared/repositories/work_repository.dart' as _i10;
import 'package:kozak/shared/shared.dart' as _i9;

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
    gh.singleton<_i4.FakeClient>(() => _i4.FakeClient());
    gh.singleton<_i5.FirestoreService>(() => _i5.FirestoreService());
    gh.singleton<_i6.StorageService>(() => _i6.StorageService());
    gh.singleton<_i7.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i8.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.singleton<_i9.IWorkRepository>(() => _i10.WorkRepository());
    gh.lazySingleton<_i9.IStorage>(() => _i11.SecureStorageRepository());
    gh.singleton<_i9.IDiscountRepository>(() => _i12.DiscountRepository());
    gh.singleton<_i9.IInvestorsRepository>(() => _i13.InvestorsRepository());
    gh.singleton<_i9.IHomeRepository>(() => _i14.HomeRepository());
    gh.factory<_i15.InvestorsWatcherBloc>(() => _i15.InvestorsWatcherBloc(
        investorsRepository: gh<_i9.IInvestorsRepository>()));
    gh.singleton<_i9.IInformationRepository>(
        () => _i16.InformationRepository());
    gh.singleton<_i9.IStoryRepository>(() => _i17.StoryRepository());
    gh.factory<_i18.StoryWatcherBloc>(() =>
        _i18.StoryWatcherBloc(storyRepository: gh<_i9.IStoryRepository>()));
    gh.singleton<_i9.ITagsRepository>(() => _i19.TagsRepository());
    gh.singleton<_i9.IFeedbackRepository>(() => _i20.FeedbackRepository());
    gh.factory<_i21.WorkEmployeeWatcherBloc>(() => _i21.WorkEmployeeWatcherBloc(
        workRepository: gh<_i9.IWorkRepository>()));
    gh.factory<_i22.HomeWatcherBloc>(
        () => _i22.HomeWatcherBloc(homeRepository: gh<_i9.IHomeRepository>()));
    gh.factory<_i23.InformationWatcherBloc>(() => _i23.InformationWatcherBloc(
        informationRepository: gh<_i9.IInformationRepository>()));
    gh.singleton<_i9.IAppAuthenticationRepository>(
        () => _i24.AppAuthenticationRepository(
              gh<_i9.IStorage>(),
              gh<_i7.FirebaseAuth>(),
              gh<_i8.GoogleSignIn>(),
              gh<_i9.CacheClient>(),
            ));
    gh.factory<_i25.MyStoryWatcherBloc>(() => _i25.MyStoryWatcherBloc(
          storyRepository: gh<_i9.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i26.StoryAddBloc>(() => _i26.StoryAddBloc(
          storyRepository: gh<_i9.IStoryRepository>(),
          iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i27.DiscountWatcherBloc>(() => _i27.DiscountWatcherBloc(
        discountRepository: gh<_i9.IDiscountRepository>()));
    gh.factory<_i28.FeedbackBloc>(() => _i28.FeedbackBloc(
          feedbackRepository: gh<_i9.IFeedbackRepository>(),
          appAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i29.SignUpBloc>(() => _i29.SignUpBloc(
        iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>()));
    gh.singleton<_i30.AuthenticationRepository>(() =>
        _i30.AuthenticationRepository(gh<_i9.IAppAuthenticationRepository>()));
    gh.factory<_i31.MyDiscountsWatcherBloc>(() => _i31.MyDiscountsWatcherBloc(
          discountRepository: gh<_i9.IDiscountRepository>(),
          iAppAuthenticationRepository: gh<_i9.IAppAuthenticationRepository>(),
        ));
    gh.factory<_i32.LoginBloc>(() => _i32.LoginBloc(
        authenticationRepository: gh<_i9.AuthenticationRepository>()));
    gh.factory<_i33.AuthenticationServicesCubit>(() =>
        _i33.AuthenticationServicesCubit(
            authenticationRepository: gh<_i9.AuthenticationRepository>()));
    gh.singleton<_i34.AuthenticationBloc>(() => _i34.AuthenticationBloc(
        authenticationRepository: gh<_i9.AuthenticationRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i35.FirebaseModule {}
