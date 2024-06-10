import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'investors_watcher_event.dart';
part 'investors_watcher_state.dart';
part 'investors_watcher_bloc.freezed.dart';

@Injectable()
class InvestorsWatcherBloc
    extends Bloc<InvestorsWatcherEvent, InvestorsWatcherState> {
  InvestorsWatcherBloc({required IInvestorsRepository investorsRepository})
      : _investorsRepository = investorsRepository,
        super(
          const InvestorsWatcherState(
            fundItems: [],
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
  }
  final IInvestorsRepository _investorsRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _investorsRepository.getFunds();
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l.toInvestors(),
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        InvestorsWatcherState(
          fundItems: r,
          loadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }
}
