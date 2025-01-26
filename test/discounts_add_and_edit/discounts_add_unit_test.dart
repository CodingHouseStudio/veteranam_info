import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/components/discounts_add/field_models/field_models.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.discountsAdd} ${KGroupText.bloc}', () {
    Future<DateTime> period() async => KTestVariables.nextDateTime;
    // late DiscountsAddBloc discountsAddBloc;
    late IDiscountRepository mockDiscountsRepository;
    late ICompanyRepository mockCompanyRepository;
    late ICitiesRepository mockCitiesRepository;

    setUp(() {
      LocalizedDateTime.enDateString = KTestVariables
          .blocSendDiscountModel.expiration!.en!
          .replaceAll('Up to ', '');
      LocalizedDateTime.ukDateString = KTestVariables
          .blocSendDiscountModel.expiration!.uk
          .replaceAll('До ', '');
      StringDartExtension.date = KTestVariables.nextDateTime;
      ExtendedDateTime.id = KTestVariables.blocSendDiscountModel.id;
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockDiscountsRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();
      mockCitiesRepository = MockICitiesRepository();

      when(
        mockDiscountsRepository.getDiscountItems(
          showOnlyBusinessDiscounts: false,
        ),
      ).thenAnswer(
        (_) => Stream.value([KTestVariables.blocSendDiscountModel]),
      );

      when(
        mockCitiesRepository.getCities(),
      ).thenAnswer(
        (_) async => Right(KTestVariables.cityModelItems),
      );

      when(
        mockCompanyRepository.currentUserCompany,
      ).thenAnswer(
        (_) => KTestVariables.fullCompanyModel,
      );
      when(
        mockDiscountsRepository
            .addDiscount(KTestVariables.blocSendDiscountModel),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      // discountsAddBloc = DiscountsAddBloc(
      //   discountRepository: mockDiscountsRepository,
      //   companyRepository: mockCompanyRepository,
      //   citiesRepository: mockCitiesRepository,
      //   discount: null,
      //   discountId: null,
      // );
    });
    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when update fields correct and save',
      build: () => DiscountsAddBloc(
        discountRepository: mockDiscountsRepository,
        companyRepository: mockCompanyRepository,
        citiesRepository: mockCitiesRepository,
        discount: null,
        discountId: null,
      ),
      act: (bloc) async {
        // bloc.add(
        //   const DiscountsAddEvent.started(),
        // );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) =>
                  state.categoryList.isNotEmpty && state.citiesList.isNotEmpty,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(
            const DiscountsAddEvent.indefinitelyUpdate(),
          )
          ..add(
            DiscountsAddEvent.periodUpdate(
              period(),
            ),
          );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) => state.isIndefinitely == false,
            ),
            // predicate<DiscountsAddState>(
            //   (state) => state.category.isValid,
            // ),
            predicate<DiscountsAddState>(
              (state) => state.period.isValid,
            ),
          ]),
          reason: 'Wait Change field',
        );
        bloc
          ..add(
            DiscountsAddEvent.titleUpdate(
              KTestVariables.blocSendDiscountModel.title.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestVariables.blocSendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestVariables.blocSendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            const DiscountsAddEvent.discountAddItem(
              '20',
            ),
          )
          ..add(
            const DiscountsAddEvent.discountRemoveItem(
              '20',
            ),
          )
          ..add(
            DiscountsAddEvent.discountRemoveItem(
              KTestVariables.blocSendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestVariables.blocSendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans.getTranslateModel.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans.getTranslateModel.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.all.getTranslateModel.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityRemoveItem(
              EligibilityEnum.all.getTranslateModel.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityRemoveItem(
              EligibilityEnum.veterans.getTranslateModel.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans.getTranslateModel.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestVariables.blocSendDiscountModel.directLink!,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.categoryAdd(
              KAppText.discountsCategories.first,
            ),
          )
          ..add(
            DiscountsAddEvent.categoryAdd(
              KAppText.discountsCategories.first,
            ),
          )
          ..add(
            DiscountsAddEvent.categoryAdd(
              KAppText.discountsCategories.last,
            ),
          )
          ..add(
            DiscountsAddEvent.categoryRemove(
              KAppText.discountsCategories.last,
            ),
          )
          ..add(
            DiscountsAddEvent.categoryRemove(
              KAppText.discountsCategories.first,
            ),
          )
          ..add(
            DiscountsAddEvent.categoryAdd(
              KTestVariables.blocSendDiscountModel.category.first.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestVariables.blocSendDiscountModel.location!.first.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestVariables.blocSendDiscountModel.location!.first.uk,
            ),
          )
          ..add(
            const DiscountsAddEvent.cityAdd(
              'test',
            ),
          )
          ..add(
            const DiscountsAddEvent.cityRemove(
              'test',
            ),
          )
          ..add(
            DiscountsAddEvent.cityRemove(
              KTestVariables.blocSendDiscountModel.location!.first.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestVariables.blocSendDiscountModel.location!.first.uk,
            ),
          )
          ..add(
            const DiscountsAddEvent.onlineSwitch(),
          )
          ..add(
            const DiscountsAddEvent.onlineSwitch(),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestVariables.blocSendDiscountModel.description.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.requirementsUpdate(
              KTestVariables.blocSendDiscountModel.requirements!.uk,
            ),
          )
          ..add(const DiscountsAddEvent.send());
      },
      expect: () async => [
        // const DiscountsAddState(
        //   isOnline: false,
        //   discount: null,
        //   categoryList: KAppText.discountsCategories,
        //   citiesList: [],
        //   isIndefinitely: true,
        //   category: CategoriesFieldModel.pure(),
        //   city: CitiesFieldModel.pure(),
        //   period: DateFieldModel.pure(),
        //   title: MessageFieldModel.pure(),
        //   discounts: DiscountsFieldModel.pure(),
        //   link: LinkFieldModel.pure(),
        //   description: MessageFieldModel.pure(),
        //   requirements: MessageFieldModel.pure(),
        //   formState: DiscountsAddEnum.initial,
        //   eligibility: EligibilityFieldModel.pure(),
        // ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          requirements: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: false,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          requirements: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.detailInProgress,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: false,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          requirements: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.detailInProgress,
          period: DateFieldModel.dirty(KTestVariables.nextDateTime),
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.title.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value.length == 2 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isNotValid &&
              state.discounts.value.isEmpty &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        // predicate<DiscountsAddState>(
        //   (state) =>
        //       state.eligibility.isValid &&
        //       state.eligibility.value.length == 1 &&
        //       state.formState == DiscountsAddEnum.inProgress,
        // ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility.isValid &&
              state.eligibility.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility.isValid &&
              state.eligibility.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility.isNotValid &&
              state.eligibility.value.isEmpty &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility.isValid &&
              state.eligibility.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.category.isValid &&
              state.category.value.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.category.isValid &&
              state.category.value.length == 2 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.category.isValid &&
              state.category.value.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.category.isNotValid &&
              state.category.value.isEmpty &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.category.isValid &&
              state.category.value.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.city.value.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.city.value.length == 2 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.city.value.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isNotValid &&
              state.city.value.isEmpty &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.city.value.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.isOnline &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              !state.isOnline &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.description,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.description.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.requirements.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.formState == DiscountsAddEnum.sendInProgress &&
              state.failure == null,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.formState == DiscountsAddEnum.success &&
              state.failure == null,
        ),
      ],
    );

    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when update fields incorrect, save and back',
      build: () => DiscountsAddBloc(
        discountRepository: mockDiscountsRepository,
        companyRepository: mockCompanyRepository,
        citiesRepository: mockCitiesRepository,
        discount: null,
        discountId: null,
      ),
      act: (bloc) async {
        // bloc.add(
        //   const DiscountsAddEvent.started(),
        // );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) =>
                  state.categoryList.isNotEmpty && state.citiesList.isNotEmpty,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.periodUpdate(
              period(),
            ),
          );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) => state.formState == DiscountsAddEnum.invalidData,
            ),
            // predicate<DiscountsAddState>(
            //   (state) => state.category.isValid,
            // ),
            predicate<DiscountsAddState>(
              (state) => state.period.isValid,
            ),
          ]),
          reason: 'Wait Change field',
        );
        bloc
          ..add(
            DiscountsAddEvent.titleUpdate(
              KTestVariables.blocSendDiscountModel.title.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestVariables.blocSendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans.getTranslateModel.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestVariables.blocSendDiscountModel.directLink!,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.categoryAdd(
              KAppText.discountsCategories.first,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestVariables.blocSendDiscountModel.location!.first.uk,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestVariables.blocSendDiscountModel.description.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.requirementsUpdate(
              KTestVariables.blocSendDiscountModel.requirements!.uk,
            ),
          )
          ..add(const DiscountsAddEvent.back())
          ..add(const DiscountsAddEvent.back());
      },
      expect: () async => [
        // const DiscountsAddState(
        //   isOnline: false,
        //   discount: null,
        //   eligibility: EligibilityFieldModel.pure(),
        //   categoryList: KAppText.discountsCategories,
        //   citiesList: [],
        //   isIndefinitely: true,
        //   category: CategoriesFieldModel.pure(),
        //   city: CitiesFieldModel.pure(),
        //   period: DateFieldModel.pure(),
        //   title: MessageFieldModel.pure(),
        //   discounts: DiscountsFieldModel.pure(),
        //   link: LinkFieldModel.pure(),
        //   description: MessageFieldModel.pure(),
        //   requirements: MessageFieldModel.pure(),
        //   formState: DiscountsAddEnum.initial,
        // ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          requirements: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          requirements: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.invalidData,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: DateFieldModel.dirty(KTestVariables.nextDateTime),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          requirements: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.title.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detailInvalidData,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.category.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.description,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.descriptionInvalidData,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.description.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.requirements.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.inProgress,
        ),
      ],
    );
    group(
        'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
        ' when started with discount id, update fields correct and save'
        ' unmodified', () {
      setUp(
        () => when(
          mockDiscountsRepository.getCompanyDiscount(
            id: KTestVariables.blocSendDiscountModel.id,
            companyId: KTestVariables.fullCompanyModel.id,
          ),
        ).thenAnswer(
          (_) async => Right(KTestVariables.blocSendDiscountModel),
        ),
      );
      blocTest<DiscountsAddBloc, DiscountsAddState>(
        'Bloc Test',
        build: () => DiscountsAddBloc(
          discountRepository: mockDiscountsRepository,
          companyRepository: mockCompanyRepository,
          citiesRepository: mockCitiesRepository,
          discount: null,
          discountId: null,
        ),
        act: (bloc) async {
          // bloc.add(
          //   const DiscountsAddEvent.started(),
          // );
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsAddState>(
                (state) =>
                    state.categoryList.isNotEmpty &&
                    state.citiesList.isNotEmpty,
              ),
              // predicate<DiscountsAddState>(
              //   (state) => state.citiesList.isNotEmpty,
              // ),
            ]),
            reason: 'Wait for loading data',
          );
          bloc.add(
            DiscountsAddEvent.loadedDiscount(
              discount: null,
              discountId: KTestVariables.blocSendDiscountModel.id,
            ),
          );
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsAddState>(
                (state) => state.discount != null,
              ),
            ]),
            reason: 'Wait for loading data',
          );
          bloc
            ..add(
              DiscountsAddEvent.titleUpdate(
                KTestVariables.blocSendDiscountModel.title.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.linkUpdate(
                KTestVariables.blocSendDiscountModel.directLink!,
              ),
            )
            ..add(const DiscountsAddEvent.send())
            ..add(const DiscountsAddEvent.send())
            ..add(
              DiscountsAddEvent.descriptionUpdate(
                KTestVariables.blocSendDiscountModel.description.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.requirementsUpdate(
                KTestVariables.blocSendDiscountModel.requirements!.uk,
              ),
            )
            ..add(const DiscountsAddEvent.send());
        },
        expect: () async => [
          // const DiscountsAddState(
          //   isOnline: false,
          //   discount: null,
          //   eligibility: EligibilityFieldModel.pure(),
          //   categoryList: KAppText.discountsCategories,
          //   citiesList: [],
          //   isIndefinitely: true,
          //   category: CategoriesFieldModel.pure(),
          //   city: CitiesFieldModel.pure(),
          //   period: DateFieldModel.pure(),
          //   title: MessageFieldModel.pure(),
          //   discounts: DiscountsFieldModel.pure(),
          //   link: LinkFieldModel.pure(),
          //   description: MessageFieldModel.pure(),
          //   requirements: MessageFieldModel.pure(),
          //   formState: DiscountsAddEnum.initial,
          // ),
          DiscountsAddState(
            isOnline: false,
            discount: null,
            eligibility: const EligibilityFieldModel.pure(),
            categoryList: KAppText.discountsCategories,
            citiesList: KTestVariables.cityModelItems,
            isIndefinitely: true,
            category: const CategoriesFieldModel.pure(),
            city: const CitiesFieldModel.pure(),
            period: const DateFieldModel.pure(),
            title: const MessageFieldModel.pure(),
            discounts: const DiscountsFieldModel.pure(),
            link: const LinkFieldModel.pure(),
            description: const MessageFieldModel.pure(),
            requirements: const MessageFieldModel.pure(),
            formState: DiscountsAddEnum.initial,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.discount != null &&
                state.formState == DiscountsAddEnum.initial,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.title.isValid &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.detail,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.description,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.requirements.isValid &&
                state.formState == DiscountsAddEnum.descriptionInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.sendInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.success,
          ),
        ],
      );
    });
    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when started with discount and save unmodified',
      build: () => DiscountsAddBloc(
        discountRepository: mockDiscountsRepository,
        companyRepository: mockCompanyRepository,
        citiesRepository: mockCitiesRepository,
        discount: null,
        discountId: null,
      ),
      act: (bloc) async {
        // bloc.add(
        //   const DiscountsAddEvent.started(),
        // );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) =>
                  state.categoryList.isNotEmpty && state.citiesList.isNotEmpty,
            ),
            // predicate<DiscountsAddState>(
            //   (state) => state.citiesList.isNotEmpty,
            // ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(
            DiscountsAddEvent.loadedDiscount(
              discount: KTestVariables.blocSendDiscountModel,
              discountId: KTestVariables.blocSendDiscountModel.id,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send());
      },
      expect: () async => [
        // const DiscountsAddState(
        //   isOnline: false,
        //   discount: null,
        //   eligibility: EligibilityFieldModel.pure(),
        //   categoryList: KAppText.discountsCategories,
        //   citiesList: [],
        //   isIndefinitely: true,
        //   category: CategoriesFieldModel.pure(),
        //   city: CitiesFieldModel.pure(),
        //   period: DateFieldModel.pure(),
        //   title: MessageFieldModel.pure(),
        //   discounts: DiscountsFieldModel.pure(),
        //   link: LinkFieldModel.pure(),
        //   description: MessageFieldModel.pure(),
        //   requirements: MessageFieldModel.pure(),
        //   formState: DiscountsAddEnum.initial,
        // ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          requirements: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discount != null &&
              state.formState == DiscountsAddEnum.initial,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.description,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.sendInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.success,
        ),
      ],
    );

    group(
        'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
        ' when started with discount id failure', () {
      setUp(
        () => when(
          mockDiscountsRepository.getCompanyDiscount(
            id: KTestVariables.blocSendDiscountModel.id,
            companyId: KTestVariables.fullCompanyModel.id,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        ),
      );
      blocTest<DiscountsAddBloc, DiscountsAddState>(
        'Bloc Text',
        build: () => DiscountsAddBloc(
          discountRepository: mockDiscountsRepository,
          companyRepository: mockCompanyRepository,
          citiesRepository: mockCitiesRepository,
          discount: null,
          discountId: null,
        ),
        act: (bloc) async {
          // bloc.add(
          //   const DiscountsAddEvent.started(),
          // );
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsAddState>(
                (state) =>
                    state.categoryList.isNotEmpty &&
                    state.citiesList.isNotEmpty,
              ),
              // predicate<DiscountsAddState>(
              //   (state) => state.citiesList.isNotEmpty,
              // ),
            ]),
            reason: 'Wait for loading data',
          );
          bloc.add(
            DiscountsAddEvent.loadedDiscount(
              discount: null,
              discountId: KTestVariables.blocSendDiscountModel.id,
            ),
          );
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsAddState>(
                (state) => state.failure == SomeFailure.linkWrong,
              ),
            ]),
            reason: 'Wait for loading data',
          );
          bloc.add(const DiscountsAddEvent.send());
        },
        expect: () async => [
          // const DiscountsAddState(
          //   isOnline: false,
          //   discount: null,
          //   eligibility: EligibilityFieldModel.pure(),
          //   categoryList: KAppText.discountsCategories,
          //   citiesList: [],
          //   isIndefinitely: true,
          //   category: CategoriesFieldModel.pure(),
          //   city: CitiesFieldModel.pure(),
          //   period: DateFieldModel.pure(),
          //   title: MessageFieldModel.pure(),
          //   discounts: DiscountsFieldModel.pure(),
          //   link: LinkFieldModel.pure(),
          //   description: MessageFieldModel.pure(),
          //   requirements: MessageFieldModel.pure(),
          //   formState: DiscountsAddEnum.initial,
          // ),
          DiscountsAddState(
            isOnline: false,
            discount: null,
            eligibility: const EligibilityFieldModel.pure(),
            categoryList: KAppText.discountsCategories,
            citiesList: KTestVariables.cityModelItems,
            isIndefinitely: true,
            category: const CategoriesFieldModel.pure(),
            city: const CitiesFieldModel.pure(),
            period: const DateFieldModel.pure(),
            title: const MessageFieldModel.pure(),
            discounts: const DiscountsFieldModel.pure(),
            link: const LinkFieldModel.pure(),
            description: const MessageFieldModel.pure(),
            requirements: const MessageFieldModel.pure(),
            formState: DiscountsAddEnum.initial,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.discount == null &&
                state.formState == DiscountsAddEnum.initial &&
                state.failure == SomeFailure.linkWrong,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.invalidData,
          ),
        ],
      );
    });
    group(
        'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
        ' when started failure, update fields correct and save failure', () {
      setUp(() {
        when(
          mockDiscountsRepository
              .addDiscount(KTestVariables.blocSendDiscountModel),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );

        when(
          mockCitiesRepository.getCities(),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
      });
      blocTest<DiscountsAddBloc, DiscountsAddState>(
        'Bloc Text',
        build: () => DiscountsAddBloc(
          discountRepository: mockDiscountsRepository,
          companyRepository: mockCompanyRepository,
          citiesRepository: mockCitiesRepository,
          discount: null,
          discountId: null,
        ),
        act: (bloc) async {
          // bloc.add(
          //   const DiscountsAddEvent.started(),
          // );
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsAddState>(
                (state) =>
                    state.categoryList.isNotEmpty && state.failure != null,
              ),
              // predicate<DiscountsAddState>(
              //   (state) => state.failure != null,
              // ),
            ]),
            reason: 'Wait for loading data',
          );
          bloc
            ..add(
              const DiscountsAddEvent.indefinitelyUpdate(),
            )
            ..add(
              DiscountsAddEvent.periodUpdate(
                period(),
              ),
            );
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsAddState>(
                (state) => state.isIndefinitely == false,
              ),
              // predicate<DiscountsAddState>(
              //   (state) => state.category.isValid,
              // ),
              predicate<DiscountsAddState>(
                (state) => state.period.isValid,
              ),
            ]),
            reason: 'Wait Change field',
          );
          bloc
            ..add(
              DiscountsAddEvent.titleUpdate(
                KTestVariables.blocSendDiscountModel.title.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.discountAddItem(
                KTestVariables.blocSendDiscountModel.discount.first.toString(),
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityAddItem(
                EligibilityEnum.veterans.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityAddItem(
                EligibilityEnum.all.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityAddItem(
                EligibilityEnum.veterans.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityRemoveItem(
                EligibilityEnum.all.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityAddItem(
                EligibilityEnum.veterans.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityRemoveItem(
                EligibilityEnum.veterans.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityAddItem(
                EligibilityEnum.veterans.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityAddItem(
                EligibilityEnum.combatants.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.eligibilityRemoveItem(
                EligibilityEnum.combatants.getTranslateModel.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.linkUpdate(
                KTestVariables.blocSendDiscountModel.directLink!,
              ),
            )
            ..add(const DiscountsAddEvent.send())
            ..add(
              DiscountsAddEvent.categoryAdd(
                KTestVariables.blocSendDiscountModel.category.first.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.cityAdd(
                KTestVariables.blocSendDiscountModel.location!.first.uk,
              ),
            )
            ..add(const DiscountsAddEvent.send())
            ..add(
              DiscountsAddEvent.descriptionUpdate(
                KTestVariables.blocSendDiscountModel.description.uk,
              ),
            )
            ..add(
              DiscountsAddEvent.requirementsUpdate(
                KTestVariables.blocSendDiscountModel.requirements!.uk,
              ),
            )
            ..add(const DiscountsAddEvent.send());
        },
        expect: () async => [
          // const DiscountsAddState(
          //   isOnline: false,
          //   discount: null,
          //   eligibility: EligibilityFieldModel.pure(),
          //   categoryList: KAppText.discountsCategories,
          //   citiesList: [],
          //   isIndefinitely: true,
          //   category: CategoriesFieldModel.pure(),
          //   city: CitiesFieldModel.pure(),
          //   period: DateFieldModel.pure(),
          //   title: MessageFieldModel.pure(),
          //   discounts: DiscountsFieldModel.pure(),
          //   link: LinkFieldModel.pure(),
          //   description: MessageFieldModel.pure(),
          //   requirements: MessageFieldModel.pure(),
          //   formState: DiscountsAddEnum.initial,
          // ),
          const DiscountsAddState(
            isOnline: false,
            discount: null,
            eligibility: EligibilityFieldModel.pure(),
            categoryList: KAppText.discountsCategories,
            citiesList: [],
            isIndefinitely: true,
            category: CategoriesFieldModel.pure(),
            city: CitiesFieldModel.pure(),
            period: DateFieldModel.pure(),
            title: MessageFieldModel.pure(),
            discounts: DiscountsFieldModel.pure(),
            link: LinkFieldModel.pure(),
            description: MessageFieldModel.pure(),
            requirements: MessageFieldModel.pure(),
            formState: DiscountsAddEnum.initial,
            failure: SomeFailure.serverError,
          ),
          const DiscountsAddState(
            isOnline: false,
            discount: null,
            eligibility: EligibilityFieldModel.pure(),
            categoryList: KAppText.discountsCategories,
            citiesList: [],
            isIndefinitely: false,
            category: CategoriesFieldModel.pure(),
            city: CitiesFieldModel.pure(),
            period: DateFieldModel.pure(),
            title: MessageFieldModel.pure(),
            discounts: DiscountsFieldModel.pure(),
            link: LinkFieldModel.pure(),
            description: MessageFieldModel.pure(),
            requirements: MessageFieldModel.pure(),
            formState: DiscountsAddEnum.detailInProgress,
          ),
          DiscountsAddState(
            isOnline: false,
            discount: null,
            eligibility: const EligibilityFieldModel.pure(),
            categoryList: KAppText.discountsCategories,
            citiesList: [],
            isIndefinitely: false,
            category: const CategoriesFieldModel.pure(),
            city: const CitiesFieldModel.pure(),
            period: DateFieldModel.dirty(KTestVariables.nextDateTime),
            title: const MessageFieldModel.pure(),
            discounts: const DiscountsFieldModel.pure(),
            link: const LinkFieldModel.pure(),
            description: const MessageFieldModel.pure(),
            requirements: const MessageFieldModel.pure(),
            formState: DiscountsAddEnum.detailInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.title.isValid &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.discounts.isValid &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.value.length == 1 &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.value.length == 1 &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.isNotValid &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.value.length == 1 &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.isNotValid &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.value.length == 1 &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.value.length == 2 &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.eligibility.value.length == 1 &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.link.isValid &&
                state.formState == DiscountsAddEnum.inProgress,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.detail,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.category.isValid &&
                state.formState == DiscountsAddEnum.detailInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.city.isValid &&
                state.formState == DiscountsAddEnum.detailInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.description,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.description.isValid &&
                state.formState == DiscountsAddEnum.descriptionInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) =>
                state.requirements.isValid &&
                state.formState == DiscountsAddEnum.descriptionInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) => state.formState == DiscountsAddEnum.sendInProgress,
          ),
          predicate<DiscountsAddState>(
            (state) => state.failure != null,
          ),
        ],
      );
    });
  });
}
