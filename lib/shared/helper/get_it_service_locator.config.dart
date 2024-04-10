// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kozak/components/home/bloc/home_watcher_bloc.dart' as _i8;
import 'package:kozak/shared/bloc/feedback/feedback_bloc.dart' as _i3;
import 'package:kozak/shared/bloc/filter/filter.dart' as _i4;
import 'package:kozak/shared/bloc/language/language_cubit.dart' as _i5;
import 'package:kozak/shared/repositories/home_repository.dart' as _i7;
import 'package:kozak/shared/shared.dart' as _i6;

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
    gh.factory<_i3.FeedbackBloc>(() => _i3.FeedbackBloc());
    gh.factory<_i4.FilterCubit>(() => _i4.FilterCubit());
    gh.singleton<_i5.LanguageCubit>(() => _i5.LanguageCubit());
    gh.singleton<_i6.IHomeRepository>(() => _i7.HomeRepository());
    gh.factory<_i8.HomeWatcherBloc>(
        () => _i8.HomeWatcherBloc(homeRepository: gh<_i6.IHomeRepository>()));
    return this;
  }
}
