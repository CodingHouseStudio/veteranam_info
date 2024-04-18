import 'package:bloc/bloc.dart';
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
        super(const InvestorsWatcherState.initial()) {
    on<_Started>(_onStarted);
  }
  final IInvestorsRepository _investorsRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    emit(const InvestorsWatcherState.loading());

    final result = await _investorsRepository.getFunds();
    result.fold(
      (l) => emit(
        InvestorsWatcherState.failure(l.toInvestors()),
      ),
      (r) => emit(InvestorsWatcherState.success(fundItems: r)),
    );
  }
}
