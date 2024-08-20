import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared.dart';

part 'discount_user_email_form_event.dart';
part 'discount_user_email_form_state.dart';
part 'discount_user_email_form_bloc.freezed.dart';

@Injectable()
class DiscountUserEmailFormBloc
    extends Bloc<DiscountUserEmailFormEvent, DiscountUserEmailFormState> {
  DiscountUserEmailFormBloc({
    required IDiscountRepository discountRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const _Initial(
            email: EmailFieldModel.pure(),
            formState: EmailEnum.initial,
          ),
        ) {
    on<_UpdateEmail>(_onUpdatEmail);
    on<_SendEmail>(_onSendEmail);
  }
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  void _onUpdatEmail(
    _UpdateEmail event,
    Emitter<DiscountUserEmailFormState> emit,
  ) {
    final emailFieldModel = EmailFieldModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailFieldModel,
        formState: EmailEnum.inProgress,
      ),
    );
  }

  Future<void> _onSendEmail(
    _SendEmail event,
    Emitter<DiscountUserEmailFormState> emit,
  ) async {
    if (state.email.isValid) {
      final discountUserEmailFormModel = EmailModel(
        id: ExtendedDateTime.id,
        userId: _appAuthenticationRepository.currentUser.id,
        email: state.email.value,
        date: ExtendedDateTime.current,
      );
      emit(
        state.copyWith(
          formState: EmailEnum.sending,
          email: const EmailFieldModel.pure(),
        ),
      );
      final result =
          await _discountRepository.sendEmail(discountUserEmailFormModel);
      result.fold(
        (l) => emit(
          state.copyWith(
            failure: l._toDiscountUserEmailForm(),
            formState: EmailEnum.initial,
          ),
        ),
        (r) {
          emit(
            const _Initial(
              email: EmailFieldModel.pure(),
              formState: EmailEnum.success,
            ),
          );
        },
      );
    } else {
      // final discountUserInvalidEmailFormModel = EmailModel(
      //   id: ExtendedDateTime.id,
      //   userId: _appAuthenticationRepository.currentUser.id,
      //   email: null,
      //   date: ExtendedDateTime.current,
      // );

      emit(
        state.copyWith(
          formState: EmailEnum.invalidData,
        ),
      );

      // final result = await _discountRepository
      //     .sendEmail(discountUserInvalidEmailFormModel);
      // result.fold(
      //   (l) => emit(
      //     state.copyWith(
      //       failure: l._toDiscountUserEmailForm(),
      //       formState: EmailEnum.initial,
      //     ),
      //   ),
      //   (r) {
      //     emit(
      //       const _Initial(
      //         email: EmailFieldModel.pure(),
      //         formState: EmailEnum.success,
      //       ),
      //     );
      //     debugPrint('empty email send');
      //   },
      // );
    }
  }
}
