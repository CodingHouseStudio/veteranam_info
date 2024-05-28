import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/models/employee_respond_model.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IWorkRepository)
class WorkRepository implements IWorkRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  @override
  Stream<List<WorkModel>> getWorks() => _firestoreService.getWorks();

  @override
  void addMockWorks() {
    for (var i = 0; i < 5; i++) {
      _firestoreService.addWork(
        WorkModel(
          id: '${ExtendedDateTime.id}$i',
          title: KMockText.workTitle,
          description: KMockText.workDescription,
          employerContact: KMockText.email,
          price: KMockText.workPrice,
          city: KMockText.workCity,
          companyName: KMockText.workEmployer,
          category: KMockText.workCategory,
        ),
      );
    }
  }

  @override
  Future<Either<SomeFailure, bool>> sendRespond(EmployeeRespondModel respond) {
    throw UnimplementedError();
  }
}
