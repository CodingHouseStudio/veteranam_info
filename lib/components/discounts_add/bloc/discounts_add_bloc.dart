import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'discounts_add_event.dart';
part 'discounts_add_state.dart';
part 'discounts_add_bloc.freezed.dart';

@Injectable(env: [Config.business])
class DiscountsAddBloc extends Bloc<DiscountsAddEvent, DiscountsAddState> {
  DiscountsAddBloc({
    required IDiscountRepository discountRepository,
    required IAppAuthenticationRepository appAuthenticationBloc,
  })  : _discountRepository = discountRepository,
        _appAuthenticationReporsitory = appAuthenticationBloc,
        super(
          const _Initial(
            categoryList: [],
            category: MessageFieldModel.pure(),
            city: CitiesFieldModel.pure(),
            period: MessageFieldModel.pure(),
            title: MessageFieldModel.pure(),
            discounts: DiscountsFieldModel.pure(),
            link: LinkFieldModel.pure(),
            description: MessageFieldModel.pure(),
            exclusions: MessageFieldModel.pure(),
            formState: DiscountsAddEnum.initial,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_CategoryUpdate>(_onCategoryUpdated);
    on<_CityUpdate>(_onCityUpdated);
    on<_PeriodUpdate>(_onPeriodUpdated);
    on<_TitleUpdate>(_onTitleUpdated);
    on<_DiscountUpdate>(_onDiscountUpdated);
    on<_LinkUpdate>(_onLinkUpdated);
    on<_DescriptionUpdate>(_onDescriptionUpdated);
    on<_ExclusionsUpdate>(_onExclusionsUpdated);
    on<_Send>(_onSend);
    on<_Back>(_onBack);
  }
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationReporsitory;

  @visibleForTesting
  static DiscountModel? sendDiscountModel;
  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountsAddState> emit,
  ) async {
    final discounts = await _discountRepository.getDiscountItems().first;

    final uniqueCategories =
        discounts.expand((discount) => discount.category).toSet().toList();

    emit(
      _Initial(
        categoryList: uniqueCategories,
        category: const MessageFieldModel.pure(),
        city: const CitiesFieldModel.pure(),
        period: const MessageFieldModel.pure(),
        title: const MessageFieldModel.pure(),
        discounts: const DiscountsFieldModel.pure(),
        link: const LinkFieldModel.pure(),
        description: const MessageFieldModel.pure(),
        exclusions: const MessageFieldModel.pure(),
        formState: DiscountsAddEnum.initial,
      ),
    );
  }

  void _onCategoryUpdated(
    _CategoryUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final categoryFieldModel = MessageFieldModel.dirty(event.category);

    emit(
      state.copyWith(
        category: categoryFieldModel,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  void _onCityUpdated(
    _CityUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final cityFieldModel = state.city.addValue(event.city);

    emit(
      state.copyWith(
        city: cityFieldModel,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  void _onPeriodUpdated(
    _PeriodUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final periodFieldModel =
        event.period == null ? null : MessageFieldModel.dirty(event.period!);

    emit(
      state.copyWith(
        period: periodFieldModel,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  void _onTitleUpdated(
    _TitleUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final titleFieldModel = MessageFieldModel.dirty(event.title);

    emit(
      state.copyWith(
        title: titleFieldModel,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onDiscountUpdated(
    _DiscountUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final discountsFieldModel = state.discounts.addValue(
      event.discount,
    );

    emit(
      state.copyWith(
        discounts: discountsFieldModel,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onLinkUpdated(
    _LinkUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final linkFieldModel = LinkFieldModel.dirty(event.link);

    emit(
      state.copyWith(
        link: linkFieldModel,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onDescriptionUpdated(
    _DescriptionUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final descriptionFieldModel = MessageFieldModel.dirty(event.description);

    emit(
      state.copyWith(
        description: descriptionFieldModel,
        formState: DiscountsAddEnum.descriptionInProgress,
      ),
    );
  }

  void _onExclusionsUpdated(
    _ExclusionsUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final exclusionsFieldModel = MessageFieldModel.dirty(event.exclusions);

    emit(
      state.copyWith(
        exclusions: exclusionsFieldModel,
        formState: DiscountsAddEnum.descriptionInProgress,
      ),
    );
  }

  void _onBack(
    _Back event,
    Emitter<DiscountsAddState> emit,
  ) {
    final discountsAddEnum = state.formState.isDescription
        ? DiscountsAddEnum.detailInProgress
        : DiscountsAddEnum.inProgress;

    emit(
      state.copyWith(
        formState: discountsAddEnum,
      ),
    );
  }

  Future<void> _onSend(
    _Send event,
    Emitter<DiscountsAddState> emit,
  ) async {
    if (state.formState.isMain) {
      if (Formz.validate([state.category, state.city]) &&
          (state.period?.isValid ?? true)) {
        emit(state.copyWith(formState: DiscountsAddEnum.detail));
      } else {
        emit(state.copyWith(formState: DiscountsAddEnum.invalidData));
      }
      return;
    }
    if (state.formState.isDetail) {
      if (Formz.validate([state.title, state.discounts, state.link])) {
        emit(state.copyWith(formState: DiscountsAddEnum.description));
      } else {
        emit(state.copyWith(formState: DiscountsAddEnum.detailInvalidData));
      }
      return;
    }
    if (Formz.validate([state.description, state.exclusions])) {
      final discount = DiscountModel(
        id: ExtendedDateTime.id,
        discount: state.discounts.getValue,
        title: state.title.value,
        titleEN: null,
        category: [state.category.value],
        categoryEN: null,
        subcategory: null,
        subcategoryEN: null,
        location: state.city.value,
        description: state.description.value,
        descriptionEN: null,
        requirements: null,
        requirementsEN: null,
        territory: null,
        territoryEN: null,
        exclusions: state.exclusions.value,
        expiration: state.period?.value,
        dateVerified: ExtendedDateTime.current,
        link: state.link.value,
        userId: _appAuthenticationReporsitory.currentUser.id,
        userName: _appAuthenticationReporsitory.currentUser.name,
      );
      final result =
          await _discountRepository.addDiscount(sendDiscountModel ?? discount);
      result.fold(
        (l) => emit(state.copyWith(failure: l._toDiscountsAdd())),
        (r) => emit(
          state.copyWith(
            formState: DiscountsAddEnum.success,
            failure: null,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(formState: DiscountsAddEnum.descriptionInvalidData),
      );
    }
  }
}