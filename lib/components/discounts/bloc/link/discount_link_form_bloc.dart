import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'discount_link_form_bloc.freezed.dart';
part 'discount_link_form_event.dart';
part 'discount_link_form_state.dart';

@Injectable()
class DiscountLinkFormBloc
    extends Bloc<DiscountLinkFormEvent, DiscountLinkFormState> {
  DiscountLinkFormBloc({
    required IDiscountRepository discountRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const _Initial(
            link: LinkFieldModel.pure(),
            formState: LinkEnum.initial,
          ),
        ) {
    on<_UpdateLink>(_onUpdatLink);
    on<_SendLink>(_onSendLink);
  }
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  void _onUpdatLink(
    _UpdateLink event,
    Emitter<DiscountLinkFormState> emit,
  ) {
    final linkFieldModel = LinkFieldModel.dirty(event.link);
    emit(state.copyWith(link: linkFieldModel, formState: LinkEnum.inProgress));
  }

  void _onSendLink(
    _SendLink event,
    Emitter<DiscountLinkFormState> emit,
  ) {
    emit(
      state.copyWith(
        formState: LinkEnum.success,
      ),
    );
    if (state.link.value != null && state.link.isValid) {
      final discountLinkFormModel = LinkModel(
        id: ExtendedDateTime.id,
        userId: _appAuthenticationRepository.currentUser.id,
        link: state.link.value!,
        date: ExtendedDateTime.current,
      );

      emit(
        const _Initial(
          link: LinkFieldModel.pure(),
          formState: LinkEnum.success,
        ),
      );
      // emit(
      //   state.copyWith(
      //     formState: LinkEnum.sending,
      //     link: const LinkFieldModel.pure(),
      //   ),
      // );
      // final result =
      unawaited(_discountRepository.sendLink(discountLinkFormModel));
      // result.fold(
      //   (l) => emit(
      //     state.copyWith(
      //       failure: l._toDiscountLinkForm(),
      //       formState: LinkEnum.initial,
      //     ),
      //   ),
      //   (r) {
      //     emit(
      //       const _Initial(
      //         link: LinkFieldModel.pure(),
      //         formState: LinkEnum.success,
      //       ),
      //     );
      //   },
      // );
    }
  }
}
