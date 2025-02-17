import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/discounts_add/field_models/field_models.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discounts_add_bloc.freezed.dart';
part 'discounts_add_event.dart';
part 'discounts_add_state.dart';

@Injectable(env: [Config.business])
class DiscountsAddBloc extends Bloc<DiscountsAddEvent, DiscountsAddState> {
  DiscountsAddBloc({
    required IDiscountRepository discountRepository,
    required ICompanyRepository companyRepository,
    required ICitiesRepository citiesRepository,
    @factoryParam required DiscountModel? discount,
    @factoryParam required String? discountId,
  })  : _discountRepository = discountRepository,
        _companyRepository = companyRepository,
        _citiesRepository = citiesRepository,
        super(
          const _Initial(
            discount: null,
            categoryList: [],
            category: CategoriesFieldModel.pure(),
            city: CitiesFieldModel.pure(),
            period: DateFieldModel.pure(),
            title: MessageFieldModel.pure(),
            discounts: DiscountsFieldModel.pure(),
            eligibility: EligibilityFieldModel.pure(),
            link: LinkFieldModel.pure(),
            description: MessageFieldModel.pure(),
            requirements: MessageFieldModel.pure(),
            email: EmailFieldModel.pure(),
            formState: DiscountsAddEnum.initial,
            citiesList: [],
            isIndefinitely: true,
            isOnline: false,
          ),
        ) {
    // init method
    _onStarted();
    // init method
    on<_LoadedDiscount>(_onLoadedDiscount);
    on<_CategoryAdd>(_onCategoryAdd);
    on<_CategoryRemove>(_onCategoryRemove);
    on<_CityAdd>(_onCityAdd);
    on<_CityRemove>(_onCityRemove);
    on<_OnlineSwitch>(_onOnlineSwitch);
    on<_PeriodUpdate>(_onPeriodUpdated);
    on<_IndefinitelyUpdate>(_onIndefinitelyUpdate);
    on<_TitleUpdate>(_onTitleUpdated);
    on<_DiscountAddItem>(_onDiscountAddItem);
    on<_DiscountRemoveItem>(_onDiscountRemoveItem);
    on<_EligibilityAddItem>(_onEligibilityAddItem);
    on<_EligibilityRemoveItem>(_onEligibilityRemoveItem);
    on<_LinkUpdate>(_onLinkUpdated);
    on<_DescriptionUpdate>(_onDescriptionUpdated);
    on<_RequirementsUpdate>(_onRequirementsUpdated);
    on<_EmailUpdate>(_onEmailUpdated);
    on<_Send>(_onSend);
    on<_Back>(_onBack);
    on<_CloseDialog>(_onCloseDialog);

    add(
      DiscountsAddEvent.loadedDiscount(
        discount: discount,
        discountId: discountId,
      ),
    );
  }
  final IDiscountRepository _discountRepository;
  final ICompanyRepository _companyRepository;
  final ICitiesRepository _citiesRepository;

  Future<void> _onStarted(
      // _Started event,
      // Emitter<DiscountsAddState> emit,
      ) async {
    // TODO(firebase): add categories spreadsheet, remove hardcode categories
    // ignore: invalid_use_of_visible_for_testing_member
    emit(
      state.copyWith(
        categoryList: KAppText.discountsCategories,
      ),
    );

    final result = await _citiesRepository.getCities();

    result.fold(
      // ignore: invalid_use_of_visible_for_testing_member
      (l) => emit(state.copyWith(failure: l)),
      // ignore: invalid_use_of_visible_for_testing_member
      (r) => emit(state.copyWith(citiesList: r)),
    );
  }

  Future<void> _onLoadedDiscount(
    _LoadedDiscount event,
    Emitter<DiscountsAddState> emit,
  ) async {
    DiscountModel? discount;
    if (event.discount != null) {
      discount = event.discount;
    } else if (event.discountId != null) {
      if (_companyRepository.currentUserCompany.isNotEmpty &&
          _companyRepository.currentUserCompany.id !=
              CompanyCacheRepository.companyCacheId) {
        final result = await _discountRepository.getCompanyDiscount(
          companyId: _companyRepository.currentUserCompany.id,
          id: event.discountId!,
        );
        result.fold(
          (l) => emit(state.copyWith(failure: SomeFailure.linkWrong)),
          (r) => discount = r,
        );
      }
    }

    if (discount != null) {
      final periodIsNull = discount!.expiration == null ||
          discount!.expiration!.uk.isEmpty ||
          discount!.expiration!.uk.toLowerCase() == 'до кінця воєнного стану' ||
          discount!.expiration!.uk.toLowerCase() == 'щомісяця оновлюється';
      emit(
        state.copyWith(
          discount: discount,
          category: CategoriesFieldModel.dirty(
            discount!.category.getTrsnslation(
              isEnglish: false,
            ),
          ),
          city: discount!.location == null
              ? const CitiesFieldModel.pure()
              : CitiesFieldModel.dirty(
                  discount!.location!.getTrsnslation(
                    isEnglish: false,
                  ),
                ),
          period: periodIsNull
              ? const DateFieldModel.pure()
              : DateFieldModel.dirty(
                  discount!.expiration?.uk.getDateDiscountString(
                    Language.ukraine.value.languageCode,
                  ),
                ),
          title: MessageFieldModel.dirty(discount!.title.uk),
          discounts: DiscountsFieldModel.dirty(
            List.generate(
              discount!.discount.length,
              (index) => '${discount!.discount.elementAt(index)}%',
            ),
          ),
          eligibility: EligibilityFieldModel.dirty(
            discount!.eligibility,
          ),
          link: LinkFieldModel.dirty(discount!.directLink),
          description: MessageFieldModel.dirty(discount!.description.uk),
          requirements: discount!.requirements == null
              ? const MessageFieldModel.pure()
              : MessageFieldModel.dirty(discount!.requirements!.uk),
          formState: DiscountsAddEnum.initial,
          isIndefinitely: periodIsNull,
          isOnline: discount!.subLocation?.isOnline ?? false,
          email: EmailFieldModel.dirty(
            _companyRepository.currentUserCompany.userEmails
                    .elementAtOrNull(0) ??
                '',
          ),
        ),
      );
    }
  }

  void _onCategoryAdd(
    _CategoryAdd event,
    Emitter<DiscountsAddState> emit,
  ) {
    final categoryFieldModel = CategoriesFieldModel.dirty(
      state.category.value.addFieldModel(event.category),
    );

    emit(
      state.copyWith(
        category: categoryFieldModel,
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onCategoryRemove(
    _CategoryRemove event,
    Emitter<DiscountsAddState> emit,
  ) {
    final categotiesList =
        state.category.value.removeFieldModel(event.category);
    final categoryFieldModel = categotiesList.isEmpty
        ? const CategoriesFieldModel.pure()
        : CategoriesFieldModel.dirty(categotiesList);

    emit(
      state.copyWith(
        category: categoryFieldModel,
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onCityAdd(
    _CityAdd event,
    Emitter<DiscountsAddState> emit,
  ) {
    final cityFieldModel = CitiesFieldModel.dirty(
      state.city.value.addFieldModel(event.city),
    );

    emit(
      state.copyWith(
        city: cityFieldModel,
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
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
        formState: DiscountsAddEnum.detailInProgress,
      ),
    );
  }

  void _onOnlineSwitch(
    _OnlineSwitch event,
    Emitter<DiscountsAddState> emit,
  ) {
    emit(
      state.copyWith(
        isOnline: !state.isOnline,
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
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
        formState: DiscountsAddEnum.detailInProgress,
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
    if (date == null) return;
    final periodFieldModel = DateFieldModel.dirty(date);

    emit(
      state.copyWith(
        period: periodFieldModel,
        failure: null,
        formState: DiscountsAddEnum.detailInProgress,
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
        formState: DiscountsAddEnum.inProgress,
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
        formState: DiscountsAddEnum.inProgress,
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
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  void _onEligibilityAddItem(
    _EligibilityAddItem event,
    Emitter<DiscountsAddState> emit,
  ) {
    if (state.eligibility.value.contains(EligibilityEnum.all)) return;
    final eligibilityEnum = event.eligibility.toEligibility;
    final EligibilityFieldModel eligibilityFieldModel;
    if (eligibilityEnum == EligibilityEnum.all) {
      eligibilityFieldModel =
          const EligibilityFieldModel.dirty([EligibilityEnum.all]);
    } else {
      final List<EligibilityEnum> eligiblityList;
      if (state.eligibility.value.contains(eligibilityEnum)) {
        eligiblityList = [eligibilityEnum];
      } else {
        eligiblityList = List.from(state.eligibility.value)
          ..add(eligibilityEnum);
      }
      eligibilityFieldModel = EligibilityFieldModel.dirty(
        eligiblityList,
      );
    }

    emit(
      state.copyWith(
        eligibility: eligibilityFieldModel,
        failure: null,
        formState: DiscountsAddEnum.inProgress,
      ),
    );
  }

  void _onEligibilityRemoveItem(
    _EligibilityRemoveItem event,
    Emitter<DiscountsAddState> emit,
  ) {
    final eliglibilityValue = event.eligibility.toEligibility;
    if (!state.eligibility.value.contains(eliglibilityValue)) return;
    final eligibilityList = (List<EligibilityEnum>.from(state.eligibility.value)
      ..remove(eliglibilityValue));
    final eligibilityFieldModel = eligibilityList.isEmpty
        ? const EligibilityFieldModel.pure()
        : EligibilityFieldModel.dirty(eligibilityList);

    emit(
      state.copyWith(
        eligibility: eligibilityFieldModel,
        failure: null,
        formState: DiscountsAddEnum.inProgress,
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
        formState: DiscountsAddEnum.inProgress,
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

  void _onRequirementsUpdated(
    _RequirementsUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final requirementsFieldModel = MessageFieldModel.dirty(event.requirements);

    emit(
      state.copyWith(
        requirements: requirementsFieldModel,
        failure: null,
        formState: DiscountsAddEnum.descriptionInProgress,
      ),
    );
  }

  void _onEmailUpdated(
    _EmailUpdate event,
    Emitter<DiscountsAddState> emit,
  ) {
    final emailFieldModel = EmailFieldModel.dirty(event.email);

    emit(
      state.copyWith(
        email: emailFieldModel,
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
        failure: null,
        formState: discountsAddEnum,
      ),
    );
  }

  void _onCloseDialog(
    _CloseDialog event,
    Emitter<DiscountsAddState> emit,
  ) {
    emit(
      state.copyWith(
        failure: null,
        formState: DiscountsAddEnum.descriptionInProgress,
      ),
    );
  }

  Future<void> _onSend(
    _Send event,
    Emitter<DiscountsAddState> emit,
  ) async {
    if (state.formState.isMain) {
      if (Formz.validate([
        state.title,
        state.discounts,
        state.link,
        state.eligibility,
      ])) {
        emit(state.copyWith(formState: DiscountsAddEnum.detail));
      } else {
        emit(state.copyWith(formState: DiscountsAddEnum.invalidData));
      }
      return;
    }
    if (state.formState.isDetail) {
      if (state.category.isValid &&
          (state.city.isValid || state.isOnline) &&
          (state.period.isValid || state.isIndefinitely)) {
        emit(state.copyWith(formState: DiscountsAddEnum.description));
      } else {
        emit(state.copyWith(formState: DiscountsAddEnum.detailInvalidData));
      }
      return;
    }
    if (state.description.isValid &&
        (!_companyRepository.currentUserCompany.isAdmin ||
            state.email.isValid)) {
      if (state.discount == null &&
          state.formState != DiscountsAddEnum.showDialog) {
        emit(
          state.copyWith(
            formState: DiscountsAddEnum.showDialog,
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          formState: DiscountsAddEnum.sendInProgress,
        ),
      );
      final String? companyId;

      if (_companyRepository.currentUserCompany.isAdmin &&
          state.discount == null) {
        companyId = ExtendedDateTime.id;
      } else {
        companyId = _companyRepository.currentUserCompany.isAdmin
            ? state.discount?.userId
            : _companyRepository.currentUserCompany.id;
      }
      //state.requirements
      final discount = (state.discount ?? discountModel).copyWith(
        discount: state.discounts.getValue
            .where(
              (element) => element != null,
            )
            .cast<int>()
            .toList(),
        title: TranslateModel(uk: state.title.value),
        category: List.generate(
          state.category.value.length,
          (index) => TranslateModel(uk: state.category.value.elementAt(index)),
        ),
        location: List.generate(
          state.city.value.length,
          (index) => TranslateModel(uk: state.city.value.elementAt(index)),
        ),
        description: TranslateModel(uk: state.description.value),
        link: _companyRepository.currentUserCompany.isAdmin
            ? state.discount?.link
            : _companyRepository.currentUserCompany.link,
        company: _companyRepository.currentUserCompany.publicName == null ||
                (_companyRepository.currentUserCompany.isAdmin)
            ? state.discount?.company
            : TranslateModel(
                uk: _companyRepository.currentUserCompany.publicName!,
              ),
        eligibility: state.eligibility.value,
        requirements: TranslateModel(
          uk: state.requirements.value,
        ),
        expiration: _getExpiration,
        dateVerified: state.discount?.dateVerified ?? ExtendedDateTime.current,
        directLink: state.link.value,
        userId: companyId,
        userPhoto: _companyRepository.currentUserCompany.isAdmin
            ? state.discount?.userPhoto
            : _companyRepository.currentUserCompany.image,
        userName: _companyRepository.currentUserCompany.isAdmin
            ? state.discount?.userName
            : _companyRepository.currentUserCompany.companyName,
        subLocation: state.isOnline ? SubLocation.online : null,
        isVerified: !_companyRepository.currentUserCompany.isAdmin,
      );
      if (state.discount == discount) {
        emit(
          state.copyWith(
            formState: DiscountsAddEnum.success,
          ),
        );
        return;
      }

      final result = await _discountRepository.addDiscount(
        discount.copyWith(dateVerified: ExtendedDateTime.current),
      );
      if (_companyRepository.currentUserCompany.isAdmin &&
          state.discount.createCompanyIfAdd(
            emailFieldValue: state.email.value,
            companyEmail: _companyRepository.currentUserCompany.userEmails
                .elementAtOrNull(0),
          )) {
        await _companyRepository.createUpdateCompany(
          company: CompanyModel(
            id: ExtendedDateTime.idIfExistNull(companyId),
            userEmails: [state.email.value],
          ),
          imageItem: null,
        );
      }
      result.fold(
        (l) => emit(state.copyWith(failure: l)),
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

  DiscountModel get discountModel => DiscountModel(
        id: ExtendedDateTime.id,
        discount: const [],
        title: const TranslateModel(uk: ''),
        category: const [],
        // subcategory: null,
        description: const TranslateModel(uk: ''),
        requirements: null,
        // territory: null,
        dateVerified: ExtendedDateTime.current,
        link: null,
      );

  TranslateModel? get _getExpiration =>
      state.isIndefinitely ? null : state.period.getString;
}
