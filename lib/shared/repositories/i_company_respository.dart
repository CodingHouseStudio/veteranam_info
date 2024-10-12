import 'package:dartz/dartz.dart';
import 'package:veteranam/shared/shared.dart';

abstract class ICompanyRepository {
  Stream<CompanyModel> get company;
  CompanyModel get currentUserCompany;

  Future<Either<SomeFailure, bool>> updateCompany({
    required CompanyModel company,
    required ImagePickerItem? imageItem,
  });

  Future<Either<SomeFailure, bool>> deleteCompany();
  void dispose();
}
