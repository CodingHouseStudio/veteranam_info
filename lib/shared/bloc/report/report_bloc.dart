import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'report_bloc.freezed.dart';
part 'report_event.dart';
part 'report_state.dart';

@Injectable(env: [Config.user])
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc({
    required IReportRepository reportRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
    @factoryParam required String cardId,
    @factoryParam required CardEnum card,
  })  : _reportRepository = reportRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const ReportState(
            reasonComplaint: null,
            email: EmailFieldModel.pure(),
            message: ReportFieldModel.pure(),
            formState: ReportEnum.initial,
            failure: null,
            cardId: '',
            card: CardEnum.discount,
          ),
        ) {
    // on<_Started>(_onStarted);
    on<_EmailUpdated>(_onEmailUpdated);
    on<_MessageUpdated>(_onMessageUpdated);
    on<_ReasonComplaintUpdated>(_onReasonComplaintUpdated);
    on<_Send>(_onSend);
    on<_Cancel>(_onCancel);
    _onStarted(cardId: cardId, card: card);
  }
  final IReportRepository _reportRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  void _onStarted({
    required String cardId,
    required CardEnum card,
  }) {
    final email = _appAuthenticationRepository.currentUser.email;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(
      ReportState(
        reasonComplaint: null,
        email: email == null || email.isEmpty
            ? const EmailFieldModel.pure()
            : EmailFieldModel.dirty(email),
        message: const ReportFieldModel.pure(),
        formState: ReportEnum.initial,
        failure: null,
        cardId: cardId,
        card: card,
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
    final reportFieldModel = ReportFieldModel.dirty(event.message);
    emit(
      state.copyWith(
        message: reportFieldModel,
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

  void _onSend(
    _Send event,
    Emitter<ReportState> emit,
  ) {
    if (state.reasonComplaint == null ||
            (!state.formState.isNext &&
                (_appAuthenticationRepository.currentUser.email?.isEmpty ??
                    true))
        //&&
        //     state.reasonComplaint == ReasonComplaint.other ||
        // state.reasonComplaint == null
        ) {
      if (state.reasonComplaint != null) {
        emit(state.copyWith(formState: ReportEnum.next, failure: null));
      } else {
        emit(state.copyWith(formState: ReportEnum.invalidData, failure: null));
      }
      return;
    }
    // if (state.cardId != null
    // &&
    //     !((state.email == null || state.email!.isNotValid) &&
    //             _appAuthenticationRepository.isAnonymously ||
    //         (state.message == null || state.message!.isNotValid) &&
    //             state.reasonComplaint == ReasonComplaint.other)
    // ) {
    if ((state.reasonComplaint?.isOther ?? true)
        ? !Formz.validate([state.email, state.message])
        : state.email.value.isNotEmpty && state.email.isNotValid) {
      emit(
        state.copyWith(
          failure: null,
          formState: ReportEnum.nextInvalidData,
        ),
      );
      return;
    }
    if (state.email.isNotValid &&
        state.formState != ReportEnum.sumbittedWithoutEmail) {
      emit(
        state.copyWith(
          failure: null,
          formState: ReportEnum.sumbittedWithoutEmail,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        failure: null,
        formState: ReportEnum.success,
      ),
    );
    // final result =
    unawaited(
      _reportRepository.sendReport(
        ReportModel(
          id: ExtendedDateTime.id,
          reasonComplaint: state.reasonComplaint!,
          email: state.email.isNotValid ? null : state.email.value,
          message: state.message.value.isEmpty ? null : state.message.value,
          date: ExtendedDateTime.current,
          card: state.card,
          userId: _appAuthenticationRepository.currentUser.id,
          cardId: state.cardId,
        ),
      ),
    );
    // result.fold(
    //   (l) => emit(
    //     state.copyWith(
    //       formState: ReportEnum.initial,
    //       failure: l._toReport(),
    //     ),
    //   ),
    //   (r) =>
    // );
    // } else {
    //   emit(
    //     state.copyWith(formState: ReportEnum.nextInvalidData, failure: null),
    //   );
    // }
  }

  void _onCancel(
    _Cancel event,
    Emitter<ReportState> emit,
  ) {
    emit(
      state.copyWith(
        formState: ReportEnum.nextInProgress,
      ),
    );
  }
}
