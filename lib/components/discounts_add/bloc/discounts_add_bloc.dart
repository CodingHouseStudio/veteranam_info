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
    required IAppAuthenticationRepository appAuthenticationRepository,
    required ICitiesRepository citiesRepository,
  })  : _discountRepository = discountRepository,
        _appAuthenticationReporsitory = appAuthenticationRepository,
        _citiesRepository = citiesRepository,
        super(
          const _Initial(
            categoryList: [],
            category: MessageFieldModel.pure(),
            city: CitiesFieldModel.pure(),
            period: DateFieldModel.pure(),
            title: MessageFieldModel.pure(),
            discounts: DiscountsFieldModel.pure(),
            link: LinkFieldModel.pure(),
            description: MessageFieldModel.pure(),
            exclusions: MessageFieldModel.pure(),
            formState: DiscountsAddEnum.initial,
            citiesList: [],
            isIndefinitely: true,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_CategoryUpdate>(_onCategoryUpdated);
    on<_CityAdd>(_onCityAdd);
    on<_CityRemove>(_onCityRemove);
    on<_PeriodUpdate>(_onPeriodUpdated);
    on<_IndefinitelyUpdate>(_onIndefinitelyUpdate);
    on<_TitleUpdate>(_onTitleUpdated);
    on<_DiscountAddItem>(_onDiscountAddItem);
    on<_DiscountRemoveItem>(_onDiscountRemoveItem);
    on<_LinkUpdate>(_onLinkUpdated);
    on<_DescriptionUpdate>(_onDescriptionUpdated);
    on<_ExclusionsUpdate>(_onExclusionsUpdated);
    on<_Send>(_onSend);
    on<_Back>(_onBack);
  }
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationReporsitory;
  final ICitiesRepository _citiesRepository;

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
        period: const DateFieldModel.pure(),
        title: const MessageFieldModel.pure(),
        discounts: const DiscountsFieldModel.pure(),
        link: const LinkFieldModel.pure(),
        description: const MessageFieldModel.pure(),
        exclusions: const MessageFieldModel.pure(),
        formState: DiscountsAddEnum.initial,
        isIndefinitely: true,
        citiesList: [],
      ),
    );

    final result = await _citiesRepository.getCities();

    result.fold(
      (l) => emit(state.copyWith(failure: l._toDiscountsAdd())),
      (r) => emit(state.copyWith(citiesList: r)),
    );
  }

  void _onCategoryUpdated(
    _CategoryUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    if (event.category == state.category.value) return;
    final categoryFieldModel = MessageFieldModel.dirty(event.category);

    emit(
      state.copyWith(
        category: categoryFieldModel,
        failure: null,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  void _onCityAdd(
    _CityAdd event,
    Emitter<DiscountsAddState> emit,
  ) {
    final cityFieldModel =
        CitiesFieldModel.dirty(state.city.value.addFieldModel(event.city));

    emit(
      state.copyWith(
        city: cityFieldModel,
        failure: null,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  void _onCityRemove(
    _CityRemove event,
    Emitter<DiscountsAddState> emit,
  ) {
    final citiesList = state.city.value.removeFieldModel(event.city);
    final cityFieldModel = citiesList.isEmpty
        ? const CitiesFieldModel.pure()
        : CitiesFieldModel.dirty(citiesList);

    emit(
      state.copyWith(
        city: cityFieldModel,
        failure: null,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  Future<void> _onIndefinitelyUpdate(
    _IndefinitelyUpdate event,
    Emitter<DiscountsAddState> emit,
  ) async {
    emit(
      state.copyWith(
        isIndefinitely: !state.isIndefinitely,
        failure: null,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  Future<void> _onPeriodUpdated(
    _PeriodUpdate event,
    Emitter<DiscountsAddState> emit,
  ) async {
    late DateTime? date;
    try {
      date = await event.period;
    } catch (e) {
      date = null;
    }
    final periodFieldModel = DateFieldModel.dirty(date);

    emit(
      state.copyWith(
        period: periodFieldModel,
        failure: null,
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
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onDiscountAddItem(
    _DiscountAddItem event,
    Emitter<DiscountsAddState> emit,
  ) {
    final discountsFieldModel = DiscountsFieldModel.dirty(
      state.discounts.value.addFieldModel(_getAddPercent(event.discount)),
    );

    emit(
      state.copyWith(
        discounts: discountsFieldModel,
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onDiscountRemoveItem(
    _DiscountRemoveItem event,
    Emitter<DiscountsAddState> emit,
  ) {
    final discountsList =
        state.discounts.value.removeFieldModel(_getAddPercent(event.discount));
    final discountsFieldModel = discountsList.isEmpty
        ? const DiscountsFieldModel.pure()
        : DiscountsFieldModel.dirty(discountsList);

    emit(
      state.copyWith(
        discounts: discountsFieldModel,
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  String _getAddPercent(String value) {
    final intValue = int.tryParse(value);
    return intValue == null ? value : '$intValue%';
  }

  void _onLinkUpdated(
    _LinkUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final linkFieldModel = LinkFieldModel.dirty(event.link);

    emit(
      state.copyWith(
        link: linkFieldModel,
        failure: null,
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
        failure: null,
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
        failure: null,
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
          (state.period.isValid || state.isIndefinitely)) {
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
        id: ExtendedDateTime.id.customSubstring(0, 6),
        discount: state.discounts.getValue
            .where(
              (element) => element != null,
            )
            .cast<int>()
            .toList(),
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
        expiration: _getExpiration(Language.ukrain),
        expirationEN: _getExpiration(Language.english),
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

  String? _getExpiration(
    Language language,
  ) =>
      state.isIndefinitely ? null : state.period.getString(language);
}
