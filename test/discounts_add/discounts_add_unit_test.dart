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
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late ICitiesRepository mockCitiesRepository;
    setUp(() {
      ExtendedDateTime.id = KTestText.sendDiscountModel.id;
      ExtendedDateTime.current = KTestText.sendDiscountModel.dateVerified;
      mockDiscountsRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
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
        mockAppAuthenticationRepository.currentUser,
      ).thenAnswer(
        (_) => KTestText.user,
      );
      when(
        mockDiscountsRepository.addDiscount(KTestText.sendDiscountModel),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      discountsAddBloc = DiscountsAddBloc(
        discountRepository: mockDiscountsRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        citiesRepository: mockCitiesRepository,
      );
    });
    blocTest<DiscountsAddBloc, DiscountsAddState>(
      'emits [DiscountsAddState.initial(), DiscountsAddState.success()]'
      ' when update fields correct and save',
      build: () => discountsAddBloc,
      act: (bloc) async {
        bloc.add(const DiscountsAddEvent.started());
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
            DiscountsAddEvent.categoryUpdate(
              KTestText.sendDiscountModel.category.first,
            ),
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
              (state) => state.category.isValid,
            ),
            predicate<DiscountsAddState>(
              (state) => state.period.isValid,
            ),
          ]),
          reason: 'Wait Change field',
        );
        bloc
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
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link,
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
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: [],
          isIndefinitely: false,
          category: const MessageFieldModel.pure(),
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
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: const MessageFieldModel.pure(),
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
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
          period: DateFieldModel.dirty(KTestText.dateTime),
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.city.value!.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isNotValid &&
              state.city.value!.isEmpty &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.city.value!.length == 1 &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.title.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value!.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isNotValid &&
              state.discounts.value!.isEmpty &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.discounts.value!.length == 1 &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
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
        bloc.add(const DiscountsAddEvent.started());
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
            DiscountsAddEvent.categoryUpdate(
              KTestText.sendDiscountModel.category.first,
            ),
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
              (state) => state.formState == DiscountsAddEnum.invalidData,
            ),
            predicate<DiscountsAddState>(
              (state) => state.category.isValid,
            ),
            predicate<DiscountsAddState>(
              (state) => state.period.isValid,
            ),
          ]),
          reason: 'Wait Change field',
        );
        bloc
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
          ..add(const DiscountsAddEvent.send())
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
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link,
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
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: [],
          isIndefinitely: false,
          category: const MessageFieldModel.pure(),
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
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: const MessageFieldModel.pure(),
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
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: const MessageFieldModel.pure(),
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
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: KTestText.cityModelItems,
          isIndefinitely: false,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: DateFieldModel.dirty(KTestText.dateTime),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
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
              state.title.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
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

        bloc.add(const DiscountsAddEvent.started());
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
            DiscountsAddEvent.categoryUpdate(
              KTestText.sendDiscountModel.category.first,
            ),
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
              (state) => state.category.isValid,
            ),
            predicate<DiscountsAddState>(
              (state) => state.period.isValid,
            ),
          ]),
          reason: 'Wait Change field',
        );
        bloc
          ..add(
            DiscountsAddEvent.cityAdd(
              KTestText.sendDiscountModel.location!.first,
            ),
          )
          ..add(const DiscountsAddEvent.send())
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
            DiscountsAddEvent.linkUpdate(
              KTestText.sendDiscountModel.link,
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
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: [],
          isIndefinitely: false,
          category: const MessageFieldModel.pure(),
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
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: [],
          isIndefinitely: false,
          category: const MessageFieldModel.pure(),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.initial,
          failure: DiscountsAddFailure.error,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: [],
          isIndefinitely: false,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: const DateFieldModel.pure(),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        DiscountsAddState(
          categoryList: KTestText.sendDiscountModel.category,
          citiesList: [],
          isIndefinitely: false,
          category: MessageFieldModel.dirty(
            KTestText.sendDiscountModel.category.first,
          ),
          city: const CitiesFieldModel.pure(),
          period: DateFieldModel.dirty(
            KTestText.dateTime,
          ),
          title: const MessageFieldModel.pure(),
          discounts: const DiscountsFieldModel.pure(),
          link: const LinkFieldModel.pure(),
          description: const MessageFieldModel.pure(),
          exclusions: const MessageFieldModel.pure(),
          formState: DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.city.isValid &&
              state.formState == DiscountsAddEnum.inProgress,
        ),
        predicate<DiscountsAddState>(
          (state) => state.formState == DiscountsAddEnum.detail,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.title.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.discounts.isValid &&
              state.formState == DiscountsAddEnum.detailInProgress,
        ),
        predicate<DiscountsAddState>(
          (state) =>
              state.link.isValid &&
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
