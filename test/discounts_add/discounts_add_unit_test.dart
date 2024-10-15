import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.discountsAdd} ${KGroupText.bloc}', () {
    Future<DateTime> period() async => KTestText.dateTime;
    late DiscountsAddBloc discountsAddBloc;
    late IDiscountRepository mockDiscountsRepository;
    late ICompanyRepository mockCompanyRepository;
    late ICitiesRepository mockCitiesRepository;
    setUp(() {
      ExtendedDateTime.id = KTestText.sendDiscountModel.id;
      ExtendedDateTime.current = KTestText.sendDiscountModel.dateVerified;
      mockDiscountsRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();
      mockCitiesRepository = MockICitiesRepository();
      DiscountsAddBloc.sendDiscountModel = KTestText.sendDiscountModel;

      when(
        mockDiscountsRepository.getDiscountItems(),
      ).thenAnswer(
        (_) => Stream.value([KTestText.sendDiscountModel]),
      );

      when(
        mockCitiesRepository.getCities(),
      ).thenAnswer(
        (_) async => Right(KTestText.cityModelItems),
      );

      when(
        mockCompanyRepository.currentUserCompany,
      ).thenAnswer(
        (_) => const CompanyModel(id: '1', userEmails: []),
      );
      when(
        mockDiscountsRepository.addDiscount(KTestText.sendDiscountModel),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      discountsAddBloc = DiscountsAddBloc(
        discountRepository: mockDiscountsRepository,
        companyRepository: mockCompanyRepository,
        citiesRepository: mockCitiesRepository,
      );
    });
    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when update fields correct and save',
      build: () => discountsAddBloc,
      act: (bloc) async {
        bloc.add(
          const DiscountsAddEvent.started(),
        );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) => state.categoryList.isNotEmpty,
            ),
            predicate<DiscountsAddState>(
              (state) => state.citiesList.isNotEmpty,
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
              KTestText.sendDiscountModel.title,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
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
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              KTestText.sendDiscountModel.eligibility!.first,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              KTestText.sendDiscountModel.eligibility!.first,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              'test',
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityRemoveItem(
              'test',
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityRemoveItem(
              KTestText.sendDiscountModel.eligibility!.first,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              KTestText.sendDiscountModel.eligibility!.first,
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link!,
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
              KAppText.discountsCategories.first,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestText.sendDiscountModel.location!.first,
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
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestText.sendDiscountModel.description,
            ),
          )
          ..add(
            DiscountsAddEvent.exclusionsUpdate(
              KTestText.sendDiscountModel.exclusions!,
            ),
          )
          ..add(const DiscountsAddEvent.send());
      },
      expect: () async => [
        const DiscountsAddState(
          isOnline: false,
          discount: null,
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
          exclusions: MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
          eligibility: ListFieldModel.pure(),
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const ListFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const ListFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.detailInProgress,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const ListFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.detailInProgress,
          period: DateFieldModel.dirty(KTestText.dateTime),
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
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility!.isValid &&
              state.eligibility!.value.length == 2 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility!.isValid &&
              state.eligibility!.value.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility!.isNotValid &&
              state.eligibility!.value.isEmpty &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility!.isValid &&
              state.eligibility!.value.length == 1 &&
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
          (state) => state.formState == DiscountsAddEnum.description,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.description.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.exclusions.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
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
      build: () => discountsAddBloc,
      act: (bloc) async {
        bloc.add(
          const DiscountsAddEvent.started(),
        );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) => state.categoryList.isNotEmpty,
            ),
            predicate<DiscountsAddState>(
              (state) => state.citiesList.isNotEmpty,
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
              KTestText.sendDiscountModel.title,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              KTestText.sendDiscountModel.eligibility!.first,
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link!,
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
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestText.sendDiscountModel.description,
            ),
          )
          ..add(
            DiscountsAddEvent.exclusionsUpdate(
              KTestText.sendDiscountModel.exclusions!,
            ),
          )
          ..add(const DiscountsAddEvent.back())
          ..add(const DiscountsAddEvent.back());
      },
      expect: () async => [
        const DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: ListFieldModel.pure(),
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
          exclusions: MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const ListFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const ListFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.invalidData,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const ListFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: DateFieldModel.dirty(KTestText.dateTime),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
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
              state.eligibility!.isValid &&
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
              state.exclusions.isValid &&
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

    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when started failure, update fields correct and save failure',
      build: () => discountsAddBloc,
      act: (bloc) async {
        when(
          mockDiscountsRepository.addDiscount(KTestText.sendDiscountModel),
        ).thenAnswer(
          (_) async =>
              Left(SomeFailure.serverError(error: KGroupText.failureSend)),
        );

        when(
          mockCitiesRepository.getCities(),
        ).thenAnswer(
          (_) async =>
              Left(SomeFailure.serverError(error: KGroupText.failureGet)),
        );

        bloc.add(
          const DiscountsAddEvent.started(),
        );
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsAddState>(
              (state) => state.categoryList.isNotEmpty,
            ),
            predicate<DiscountsAddState>(
              (state) => state.failure != null,
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
              KTestText.sendDiscountModel.title,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestText.sendDiscountModel.discount.first.toString(),
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              KTestText.sendDiscountModel.eligibility!.first,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              KAppText.eligibilityAll,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityRemoveItem(
              KAppText.eligibilityAll,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              KAppText.eligibilityAll,
            ),
          )
          ..add(
            DiscountsAddEvent.eligibilityAddItem(
              KTestText.sendDiscountModel.eligibility!.first,
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link!,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.categoryAdd(
              KAppText.discountsCategories.first,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestText.sendDiscountModel.description,
            ),
          )
          ..add(
            DiscountsAddEvent.exclusionsUpdate(
              KTestText.sendDiscountModel.exclusions!,
            ),
          )
          ..add(const DiscountsAddEvent.send());
      },
      expect: () async => [
        const DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: ListFieldModel.pure(),
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
          exclusions: MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
        ),
        const DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: ListFieldModel.pure(),
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
          exclusions: MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
          failure: DiscountsAddFailure.error,
        ),
        const DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: ListFieldModel.pure(),
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
          exclusions: MessageFieldModel.pure(),
          formState: DiscountsAddEnum.detailInProgress,
        ),
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const ListFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: [],
          isIndefinitely: false,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: DateFieldModel.dirty(KTestText.dateTime),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
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
              state.eligibility!.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility == null &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility!.isNotValid &&
              state.eligibility!.value.isEmpty &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility == null &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.eligibility!.isValid &&
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
              state.exclusions.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.failure != null,
        ),
      ],
    );
  });
}
