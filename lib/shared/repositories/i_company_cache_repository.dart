import 'package:veteranam/shared/models/company_model.dart';

abstract class ICompanyCacheRepository {
  CompanyModel get getFromCache;
  void saveToCache({
    required CompanyModel company,
    required CompanyModel previousCompany,
  });
  void cleanCache();
}
