import 'dart:async';

import 'package:bloc/bloc.dart';
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
    on<_SendEmailAfterClose>(_onSendEmailAfterClose);
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

  void _onSendEmail(
    _SendEmail event,
    Emitter<DiscountUserEmailFormState> emit,
  ) {
    if (state.email.value.isEmpty) {
      emit(state.copyWith(formState: EmailEnum.invalidData));
      return;
    }

    final discountUserEmailFormModel = EmailModel(
      id: ExtendedDateTime.id,
      userId: _appAuthenticationRepository.currentUser.id,
      email: state.email.value,
      date: ExtendedDateTime.current,
      isValid: state.email.isValid,
    );

    emit(
      state.copyWith(
        // email: EmailFieldModel.pure(),
        formState: EmailEnum.success,
      ),
    );

    unawaited(_discountRepository.sendEmail(discountUserEmailFormModel));
  }

  void _onSendEmailAfterClose(
    _SendEmailAfterClose event,
    Emitter<DiscountUserEmailFormState> emit,
  ) {
    emit(
      const _Initial(
        email: EmailFieldModel.pure(),
        formState: EmailEnum.close,
      ),
    );

    final discountUserEmailFormModel = EmailModel(
      id: ExtendedDateTime.id,
      userId: _appAuthenticationRepository.currentUser.id,
      email: '',
      date: ExtendedDateTime.current,
      isValid: state.email.isValid,
    );

    unawaited(_discountRepository.sendEmail(discountUserEmailFormModel));
  }
}
