import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discountCard} ${KGroupText.bloc}', () {
    late DiscountCardWatcherBloc discountCardWatcherBloc;
    late IDiscountRepository mockdiscountRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      discountCardWatcherBloc = DiscountCardWatcherBloc(
        discountRepository: mockdiscountRepository,
      );
    });

    blocTest<DiscountCardWatcherBloc, DiscountCardWatcherState>(
      'emits [DiscountCardWatcherState()]'
      ' when load discountModel wuth wrong id and correct',
      build: () => discountCardWatcherBloc,
      act: (bloc) async {
        when(
          mockdiscountRepository.getDiscount(
            KTestText.discountModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => Right(KTestText.discountModelItems.first),
        );
        bloc
          ..add(const DiscountCardWatcherEvent.started(''))
          ..add(
            DiscountCardWatcherEvent.started(
              KTestText.discountModelItems.first.id,
            ),
          );
      },
      expect: () async => [
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.error,
          failure: DiscountCardFailure.wrongID,
        ),
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        DiscountCardWatcherState(
          discountModel: KTestText.discountModelItems.first,
          loadingStatus: LoadingStatus.loaded,
          failure: null,
        ),
      ],
    );

    blocTest<DiscountCardWatcherBloc, DiscountCardWatcherState>(
      'emits [DiscountCardWatcherState()]'
      ' when load discountModel ${KGroupText.failure}',
      build: () => discountCardWatcherBloc,
      act: (bloc) async {
        when(
          mockdiscountRepository.getDiscount(
            KTestText.discountModelItems.first.id,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        bloc.add(
          DiscountCardWatcherEvent.started(
            KTestText.discountModelItems.first.id,
          ),
        );
      },
      expect: () async => [
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.loading,
          failure: null,
        ),
        const DiscountCardWatcherState(
          discountModel: null,
          loadingStatus: LoadingStatus.error,
          failure: DiscountCardFailure.error,
        ),
      ],
    );
  });
}
