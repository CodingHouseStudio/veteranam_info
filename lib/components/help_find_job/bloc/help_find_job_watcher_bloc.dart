import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/models/field_models/phone_number_field_model.dart';
import 'package:kozak/shared/shared.dart';

part 'help_find_job_watcher_event.dart';

part 'help_find_job_watcher_state.dart';

part 'help_find_job_watcher_bloc.freezed.dart';

class HelpFindJobBloc extends Bloc<HelpFindJobEvent, HelpFindJobState> {
  HelpFindJobBloc({
    required IAppAuthenticationRepository iAppAuthenticationRepository,
    required IWorkRepository workRepository,
  })  : _iAppAuthenticationRepository = iAppAuthenticationRepository,
        _workRepository = workRepository,
        super(
          const HelpFindJobState(
            name: NameFieldModel.pure(),
            email: EmailFieldModel.pure(),
            phoneNumber: PhoneNumberFieldModel.pure(),
            city: '',
            isRemote: false,
            position: '',
            category: '',
            message: '',
            failure: HelpFindJobError.initial,
            fieldsIsCorrect: true,
          ),
        ) {
    on<_EmailUpdated>(_onEmailUpdated);
    on<_PhoneNumberUpdated>(_onPhoneNumberUpdated);
    on<_CityChanged>(_onCityChanged);
    on<_RemoteWorkToggled>(_onRemoteWorkToggled);
    on<_PositionChanged>(_onPositionChanged);
    on<_CategoryChanged>(_onCategoryChanged);
    on<_MessageUpdated>(_onMessageUpdated);
    on<_ResumeUploaded>(_onResumeUploaded);
    on<_LeaveRequestSubmitted>(_onLeaveRequestSubmitted);
  }

  final IAppAuthenticationRepository _iAppAuthenticationRepository;
  final IWorkRepository _workRepository;

  Future<void> _onEmailUpdated(
    _EmailUpdated event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        email: EmailFieldModel.dirty(event.email),
      ),
    );
  }

  Future<void> _onPhoneNumberUpdated(
    _PhoneNumberUpdated event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        phoneNumber: PhoneNumberFieldModel.dirty(event.number),
      ),
    );
  }

  Future<void> _onCityChanged(
    _CityChanged event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        city: event.city,
      ),
    );
  }

  Future<void> _onRemoteWorkToggled(
    _RemoteWorkToggled event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        isRemote: event.isRemote,
      ),
    );
  }

  Future<void> _onPositionChanged(
    _PositionChanged event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        position: event.position,
      ),
    );
  }

  Future<void> _onCategoryChanged(
    _CategoryChanged event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        category: event.category,
      ),
    );
  }

  Future<void> _onResumeUploaded(
    _ResumeUploaded event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        resume: event.file,
      ),
    );
  }

  Future<void> _onMessageUpdated(
    _MessageUpdated event,
    Emitter<HelpFindJobState> emit,
  ) async {
    emit(
      state.copyWith(
        message: event.message,
      ),
    );
  }

  Future<void> _onLeaveRequestSubmitted(
    _LeaveRequestSubmitted event,
    Emitter<HelpFindJobState> emit,
  ) async {
    if (!state.email.isValid ||
        !state.phoneNumber.isValid ||
        state.resume == null ||
        state.city.isEmpty ||
        state.position.isEmpty ||
        state.category.isEmpty) {
      emit(
        state.copyWith(
          failure: HelpFindJobError.initial,
          fieldsIsCorrect: false,
        ),
      );
      return;
    }

    emit(state.copyWith(fieldsIsCorrect: true));

    final result = await _workRepository.sendEmployeeRequest(
      RequestModel(
        id: ExtendedDateTime.id,
        guestId: _iAppAuthenticationRepository.currentUser.id,
        guestName: state.name.value ?? '',
        email: state.email.value,
        phoneNumber: state.phoneNumber.value,
        resume: state.resume?.path ?? '',
        timestamp: ExtendedDateTime.current,
        city: state.city,
        position: state.position,
        category: state.category,
        message: state.message,
      ),
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l.toLeaveRequestError(),
        ),
      ),
      (r) => emit(
        state.copyWith(
          failure: HelpFindJobError.none,
        ),
      ),
    );
  }
}
