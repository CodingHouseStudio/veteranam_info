import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IWorkRepository)
class WorkRepository implements IWorkRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  final StorageService _storageService = GetIt.I.get<StorageService>();
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
  Future<Either<SomeFailure, bool>> sendRespond(
    EmployeeRespondModel respond,
  ) async {
    try {
      if (respond.resume != null) {
        await _storageService.saveRespond(
          resumeModel: respond.resume!.first,
          respondId: respond.id,
        );
      }
      await _firestoreService.sendRespond(respond);

      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(SendFailure.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }
}
