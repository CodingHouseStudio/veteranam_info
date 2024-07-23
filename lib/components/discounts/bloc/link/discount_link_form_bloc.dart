import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared.dart';

part 'discount_link_form_event.dart';
part 'discount_link_form_state.dart';
part 'discount_link_form_bloc.freezed.dart';

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
    on<_Started>(_onStarted);
    on<_UpdateLink>(_onUpdatLink);
    on<_SendLink>(_onSendLink);
  }
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountLinkFormState> emit,
  ) async {
    final showLink = await _discountRepository
        .userCanSendLink(_appAuthenticationRepository.currentUser.id);
    showLink.fold(
      (l) => emit(
        _Initial(
          link: const LinkFieldModel.pure(),
          formState: LinkEnum.initial,
          failure: l._toDiscountLinkForm(),
        ),
      ),
      (r) => emit(
        _Initial(
          link: const LinkFieldModel.pure(),
          formState: r ? LinkEnum.initial : LinkEnum.notShow,
        ),
      ),
    );
  }

  void _onUpdatLink(
    _UpdateLink event,
    Emitter<DiscountLinkFormState> emit,
  ) {
    final linkFieldModel = LinkFieldModel.dirty(event.link);
    emit(state.copyWith(link: linkFieldModel, formState: LinkEnum.inProgress));
  }

  Future<void> _onSendLink(
    _SendLink event,
    Emitter<DiscountLinkFormState> emit,
  ) async {
    if (state.link.isValid) {
      final discountLinkFormModel = LinkModel(
        id: ExtendedDateTime.id,
        userId: _appAuthenticationRepository.currentUser.id,
        link: state.link.value,
        date: ExtendedDateTime.current,
      );
      final showLink =
          await _discountRepository.sendLink(discountLinkFormModel);
      showLink.fold(
        (l) => emit(
          _Initial(
            link: const LinkFieldModel.pure(),
            formState: state.formState,
            failure: l._toDiscountLinkForm(),
          ),
        ),
        (r) {
          emit(
            const _Initial(
              link: LinkFieldModel.pure(),
              formState: LinkEnum.success,
            ),
          );
          add(const DiscountLinkFormEvent.started());
        },
      );
    } else {
      emit(
        state.copyWith(
          formState: LinkEnum.invalidData,
        ),
      );
    }
  }
}
