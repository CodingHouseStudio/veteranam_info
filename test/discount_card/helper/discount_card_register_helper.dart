import 'package:veteranam/components/discount_card/bloc/discount_card_watcher_cubit.dart';
import 'package:veteranam/shared/repositories/i_discount_repository.dart';

import '../../test_dependency.dart';

late IDiscountRepository mockDiscountRepository;
void discountCardTestWIdgetRegister() {
  mockDiscountRepository = MockIDiscountRepository();

  registerFactoryParam<DiscountCardWatcherCubit, String?, void>(
    (discountId, voidValue) => DiscountCardWatcherCubit(
      discountRepository: mockDiscountRepository,
      id: discountId,
    ),
  );
}
