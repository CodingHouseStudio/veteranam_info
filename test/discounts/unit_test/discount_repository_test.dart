import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} ${KGroupText.repository} ', () {
    late IDiscountRepository mockDiscountRepository;
    late FirestoreService mockFirestoreService;
    setUp(() {
      ExtendedDateTime.id = '';
      ExtendedDateTime.current = KTestText.dateTime;
      mockFirestoreService = MockFirestoreService();
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(mockFirestoreService.getDiscounts()).thenAnswer(
          (_) => Stream.value(KTestText.repositoryDiscountModelItems),
        );
        when(
          mockFirestoreService.addDiscount(
            KTestText.repositoryDiscountModelItems.first,
          ),
        ).thenAnswer(
          (realInvocation) async {},
        );
        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
      });
      test('Discount', () async {
        expect(
          mockDiscountRepository.getDiscountItems(),
          emits(KTestText.repositoryDiscountModelItems),
        );
      });
      test('mock', () async {
        mockDiscountRepository.addMockDiscountItems();
        verify(
          mockFirestoreService.addDiscount(
            KTestText.repositoryDiscountModelItems.first,
          ),
        ).called(1);
      });
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(mockFirestoreService.getDiscounts()).thenAnswer(
          (realInvocation) => Stream.error(
            KGroupText.failureGet,
          ),
        );

        if (GetIt.I.isRegistered<FirestoreService>()) {
          GetIt.I.unregister<FirestoreService>();
        }
        GetIt.I.registerSingleton(mockFirestoreService);

        mockDiscountRepository = DiscountRepository();
      });
      test('Discount', () async {
        expect(
          mockDiscountRepository.getDiscountItems(),
          emitsError(KGroupText.failureGet),
        );
      });
    });
  });
}
