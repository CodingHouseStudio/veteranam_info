// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i11;
import 'package:kozak/shared/bloc/feedback/feedback_bloc.dart' as _i12;
import 'package:kozak/shared/bloc/filter/filter_cubit.dart' as _i3;
import 'package:kozak/shared/bloc/language/language_cubit.dart' as _i5;
import 'package:kozak/shared/data_provider/cache_provider.dart' as _i4;
import 'package:kozak/shared/data_provider/fake_provider.dart' as _i6;
import 'package:kozak/shared/data_provider/firestore_provider.dart' as _i7;
import 'package:kozak/shared/repositories/feedback_repository.dart' as _i10;
import 'package:kozak/shared/repositories/home_repository.dart' as _i9;
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
    gh.factory<_i3.FilterCubit>(() => _i3.FilterCubit());
    gh.factory<_i4.CacheClient>(() => _i4.CacheClient());
    gh.singleton<_i5.LanguageCubit>(() => _i5.LanguageCubit());
    gh.singleton<_i6.FakeClient>(() => _i6.FakeClient());
    gh.singleton<_i7.FirestoreService>(() => _i7.FirestoreService());
    gh.singleton<_i8.IHomeRepository>(() => _i9.HomeRepository());
    gh.singleton<_i8.IFeedbackRepository>(() => _i10.FeedbackRepository());
    gh.factory<_i11.HomeWatcherBloc>(
        () => _i11.HomeWatcherBloc(homeRepository: gh<_i8.IHomeRepository>()));
    gh.factory<_i12.FeedbackBloc>(() =>
        _i12.FeedbackBloc(feedbackRepository: gh<_i8.IFeedbackRepository>()));
    return this;
  }
}
