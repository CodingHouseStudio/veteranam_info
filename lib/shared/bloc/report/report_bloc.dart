import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'report_bloc.freezed.dart';
part 'report_event.dart';
part 'report_state.dart';

@Injectable()
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc({
    required IReportRepository reportRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _reportRepository = reportRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const ReportState(
            reasonComplaint: null,
            email: null,
            message: null,
            formState: ReportEnum.initial,
            failure: null,
            cardId: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_EmailUpdated>(_onEmailUpdated);
    on<_MessageUpdated>(_onMessageUpdated);
    on<_ReasonComplaintUpdated>(_onReasonComplaintUpdated);
    on<_Send>(_onSend);
  }
  final IReportRepository _reportRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  void _onStarted(
    _Started event,
    Emitter<ReportState> emit,
  ) {
    emit(
      ReportState(
        reasonComplaint: null,
        email: null,
        message: null,
        formState: ReportEnum.initial,
        failure: null,
        cardId: event.cardId,
      ),
    );
  }

  void _onEmailUpdated(
    _EmailUpdated event,
    Emitter<ReportState> emit,
  ) {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        formState: ReportEnum.nextInProgress,
        failure: null,
      ),
    );
  }

  void _onMessageUpdated(
    _MessageUpdated event,
    Emitter<ReportState> emit,
  ) {
    final messageFieldModel = MessageFieldModel.dirty(event.message);
    emit(
      state.copyWith(
        message: messageFieldModel,
        formState: ReportEnum.nextInProgress,
        failure: null,
      ),
    );
  }

  void _onReasonComplaintUpdated(
    _ReasonComplaintUpdated event,
    Emitter<ReportState> emit,
  ) {
    emit(
      state.copyWith(
        reasonComplaint: event.reasonComplaint,
        formState: ReportEnum.inProgress,
        failure: null,
      ),
    );
  }

  Future<void> _onSend(
    _Send event,
    Emitter<ReportState> emit,
  ) async {
    if (!state.formState.isNext) {
      if (state.reasonComplaint != null) {
        emit(state.copyWith(formState: ReportEnum.next, failure: null));
      } else {
        emit(state.copyWith(formState: ReportEnum.invalidData, failure: null));
      }
      return;
    }
    if (state.cardId != null &&
        !((state.email == null || state.email!.isNotValid) &&
                _appAuthenticationRepository.isAnonymously() ||
            (state.message == null || state.message!.isNotValid) &&
                state.reasonComplaint == ReasonComplaint.other)) {
      final resault = await _reportRepository.sendReport(
        ReportModel(
          id: ExtendedDateTime.id,
          reasonComplaint: state.reasonComplaint!,
          email: state.email?.value.isEmpty ?? true
              ? _appAuthenticationRepository.currentUser.email!
              : state.email!.value,
          message: state.message?.value.isEmpty ?? true
              ? null
              : state.message?.value,
          date: ExtendedDateTime.current,
          card: event.card,
          userId: _appAuthenticationRepository.currentUser.id,
          cardId: state.cardId!,
        ),
      );
      resault.fold(
        (l) => emit(
          state.copyWith(
            formState: ReportEnum.initial,
            failure: l._toReport(),
          ),
        ),
        (r) => emit(
          state.copyWith(
            failure: null,
            formState: ReportEnum.success,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(formState: ReportEnum.nextInvalidData, failure: null),
      );
    }
  }
}
