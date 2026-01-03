import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/components/discounts_add/field_models/field_models.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.discountsAdd} Admin ${KGroupText.bloc}', () {
    Future<DateTime> period() async => KTestVariables.nextDateTime;
    // late DiscountsAddBloc discountsAddBloc;
    late IDiscountRepository mockDiscountsRepository;
    late ICompanyRepository mockCompanyRepository;
    late ICitiesRepository mockCitiesRepository;

    setUp(() {
      LocalizedDateTime.enDateString = KTestVariables
          .sendDiscountAdminModel.expiration!.en!
          .replaceAll('Up to ', '');
      LocalizedDateTime.ukDateString = KTestVariables
          .sendDiscountAdminModel.expiration!.uk
          .replaceAll('До ', '');
      StringDartExtension.date = KTestVariables.nextDateTime;
      ExtendedDateTime.id = KTestVariables.sendDiscountAdminModel.id;
      ExtendedDateTime.current = KTestVariables.dateTime;
      mockDiscountsRepository = MockIDiscountRepository();
      mockCompanyRepository = MockICompanyRepository();
      mockCitiesRepository = MockICitiesRepository();

      when(
        mockDiscountsRepository.getDiscountItems(
          showOnlyBusinessDiscounts: false,
        ),
      ).thenAnswer(
        (_) => Stream.value([KTestVariables.sendDiscountAdminModel]),
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
        mockDiscountsRepository.addDiscount(
          KTestVariables.sendDiscountAdminModel,
        ),
      ).thenAnswer(
        (_) async => const Right(true),
      );
      when(
        mockCompanyRepository.createUpdateCompany(
          company: CompanyModel(
            id: KTestVariables.sendDiscountAdminModel.id,
            userEmails: [KTestVariables.userEmail],
          ),
          imageItem: null,
        ),
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
                  state.categoryList.isNotEmpty && state.citiesList.isNotEmpty,
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
              KTestVariables.sendDiscountAdminModel.title.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.discountAddItem(
              KTestVariables.sendDiscountAdminModel.discount.first.toString(),
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.all,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityRemoveItem(
              EligibilityEnum.all,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityRemoveItem(
              EligibilityEnum.veterans,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.veterans,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityAddItem(
              EligibilityEnum.combatants,
            ),
          )
          ..add(
            const DiscountsAddEvent.eligibilityRemoveItem(
              EligibilityEnum.combatants,
            ),
          )
          ..add(
            DiscountsAddEvent.linkUpdate(
              KTestVariables.sendDiscountAdminModel.directLink!,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.categoryAdd(
              KTestVariables.sendDiscountAdminModel.category.first.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestVariables.sendDiscountAdminModel.location!.first.uk,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            DiscountsAddEvent.descriptionUpdate(
              KTestVariables.sendDiscountAdminModel.description.uk,
            ),
          )
          ..add(
            DiscountsAddEvent.requirementsUpdate(
              KTestVariables.sendDiscountAdminModel.requirements!.uk,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(
            const DiscountsAddEvent.emailUpdate(
              KTestVariables.userEmail,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send());
      },
      expect: () async => [
        DiscountsAddState(
          isOnline: false,
          discount: null,
          eligibility: const EligibilityFieldModel.pure(),
          categoryList: KAppText.discountsCategories,
          citiesList: KTestVariables.cityModelItems,
          isIndefinitely: true,
          category: const CategoriesFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          email: const EmailFieldModel.pure(),
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
          email: const EmailFieldModel.pure(),
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
          email: const EmailFieldModel.pure(),
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
          (state) => state.formState == DiscountsAddEnum.descriptionInvalidData,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.email.isValid &&
              state.formState == DiscountsAddEnum.descriptionInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.showDialog,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.sendInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.failure == null &&
              state.formState == DiscountsAddEnum.success,
        ),
      ],
    );
  });
}
