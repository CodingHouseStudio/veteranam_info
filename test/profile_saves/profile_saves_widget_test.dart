import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../text_dependency.dart';
import 'helper/profile_saves_initial_helper.dart';
import 'helper/profile_saves_pump_and_helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.profileSaves} ', () {
    late IDiscountRepository mockDiscountRepository;
    late DiscountWatcherBloc discountBloc;
    setUp(() {
      mockDiscountRepository = MockIDiscountRepository();
      when(mockDiscountRepository.getDiscountItems()).thenAnswer(
        (invocation) => Stream.value(KTestText.userDiscountModelItems),
      );
    });
    void registerDiscountBloc() {
      discountBloc = DiscountWatcherBloc(
        discountRepository: mockDiscountRepository,
      );
      if (GetIt.I.isRegistered<DiscountWatcherBloc>()) {
        GetIt.I.unregister<DiscountWatcherBloc>();
      }
      GetIt.I.registerSingleton<DiscountWatcherBloc>(discountBloc);
    }

    testWidgets('${KGroupText.intial} ', (tester) async {
      registerDiscountBloc();
      await profileSavesPumpAppHelper(tester: tester);

      await profileSavesInitialHelper(tester);
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());

      testWidgets('${KGroupText.intial} ', (tester) async {
        registerDiscountBloc();
        await profileSavesPumpAppHelper(
          tester: tester,
          mockGoRouter: mockGoRouter,
        );

        await profileSavesInitialHelper(tester);
      });
    });
  });
}
