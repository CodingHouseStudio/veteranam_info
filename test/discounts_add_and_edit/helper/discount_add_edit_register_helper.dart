import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts_add/bloc/discounts_add_bloc.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IDiscountRepository mockDiscountRepository;
late ICompanyRepository mockCompanyRepository;
late ICitiesRepository mockCitiesRepository;
void discountAddEditRegister() {
  Config.roleValue = Config.business;
  ExtendedDateTime.id = KTestVariables.discountModelItems.first.id;
  ExtendedDateTime.current = KTestVariables.sendDiscountModel.dateVerified;
  ContextExtensions.pickerDate = KTestVariables.nextDateTime;
  mockDiscountRepository = MockIDiscountRepository();
  mockCompanyRepository = MockICompanyRepository();
  mockCitiesRepository = MockICitiesRepository();

  when(
    mockDiscountRepository.addDiscount(
      KTestVariables.widgetSendDiscountModel,
    ),
  ).thenAnswer((invocation) async => const Right(true));

  when(
    mockDiscountRepository.getDiscountItems(
      showOnlyBusinessDiscounts: false,
    ),
  ).thenAnswer(
    (invocation) => Stream.value(KTestVariables.discountModelItems),
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

  _registerBloc();
}

void _registerBloc() {
  // DiscountsAddBloc
  registerFactoryParam<DiscountsAddBloc, DiscountModel?, String?>(
    (discount, discountId) => DiscountsAddBloc(
      discountRepository: mockDiscountRepository,
      companyRepository: mockCompanyRepository,
      citiesRepository: mockCitiesRepository,
      discount: discount,
      discountId: discountId,
    ),
  );

  // CompanyWatcherBloc
  registerFactory<CompanyWatcherBloc>(
    () => CompanyWatcherBloc(
      companyRepository: mockCompanyRepository,
    ),
  );
}
