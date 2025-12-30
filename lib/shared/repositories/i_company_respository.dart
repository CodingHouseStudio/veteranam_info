import 'package:dartz/dartz.dart';

import 'package:veteranam/shared/shared_dart.dart';

abstract class ICompanyRepository {
  Stream<CompanyModel> get company;
  CompanyModel get currentUserCompany;

  Future<Either<SomeFailure, bool>> createUpdateCompany({
    required CompanyModel company,
    required FilePickerItem? imageItem,
  });

  Future<Either<SomeFailure, bool>> deleteCompany();
  void dispose();
}
