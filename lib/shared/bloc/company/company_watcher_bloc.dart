import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'company_watcher_event.dart';
part 'company_watcher_state.dart';
part 'company_watcher_bloc.freezed.dart';

@Injectable(
  env: [Config.business],
)
class CompanyWatcherBloc
    extends Bloc<CompanyWatcherEvent, CompanyWatcherState> {
  CompanyWatcherBloc({required ICompanyRepository companyRepository})
      : _companyRepository = companyRepository,
        super(
          _Initial(
            company: companyRepository.currentUserCompany,
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
  }

  final ICompanyRepository _companyRepository;
  StreamSubscription<CompanyModel>? _userCompanySubscription;

  Future<void> _onStarted(
    _Started event,
    Emitter<CompanyWatcherState> emit,
  ) async {
    await _userCompanySubscription?.cancel();
    _userCompanySubscription = _companyRepository.company.listen(
      (company) {
        add(
          CompanyWatcherEvent.updated(
            company,
          ),
        );
      },
      onError: (dynamic error, StackTrace stack) {
        // debugPrint('error is $error');
        add(CompanyWatcherEvent.failure(error: error, stack: stack));
      },
    );
  }

  Future<void> _onUpdated(
    _Updated event,
    Emitter<CompanyWatcherState> emit,
  ) async {
    emit(_Initial(company: event.company, failure: null));
  }

  void _onFailure(
    _Failure event,
    Emitter<CompanyWatcherState> emit,
  ) {
    // debugPrint('error is ${event.failure}');
    emit(
      _Initial(
        company: _companyRepository.currentUserCompany,
        failure: SomeFailure.serverError(
          error: event.error,
          stack: event.stack,
        )._toCompany(),
      ),
    );
  }

  @override
  Future<void> close() {
    _companyRepository.dispose();
    return super.close();
  }
}