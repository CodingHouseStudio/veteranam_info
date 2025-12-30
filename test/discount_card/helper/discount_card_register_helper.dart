import 'package:veteranam/shared/repositories/i_discount_repository.dart';
import '../../test_dependency.dart';

late IDiscountRepository mockDiscountRepository;
void discountCardTestWIdgetRegister() {
  mockDiscountRepository = MockIDiscountRepository();

  registerSingleton(mockDiscountRepository);
}
