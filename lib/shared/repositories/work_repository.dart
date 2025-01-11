// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IWorkRepository, env: [Config.development])
class WorkRepository implements IWorkRepository {
  WorkRepository({
    required FirestoreService firestoreService,
    required StorageService storageService,
  })  : _firestoreService = firestoreService,
        _storageService = storageService;
  final FirestoreService _firestoreService;
  final StorageService _storageService;
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
  Future<Either<SomeFailure, bool>> sendRespond({
    required EmployeeRespondModel respond,
    required FilePickerItem? file,
  }) async {
    try {
      late var methodRespond = respond;
      if (file != null) {
        final downloadURL = await _storageService.saveFile(
          filePickerItem: file,
          id: respond.id,
          collecltionName: FirebaseCollectionName.respond,
          file: StoragePath.resume,
          standartFileExtension: StoragePath.standartFileExtension,
        );
        if (downloadURL != null && downloadURL.isNotEmpty) {
          methodRespond = methodRespond.copyWith(
            resume: file.resume(downloadURL),
          );
        }
      }
      await _firestoreService.sendRespond(methodRespond);

      return const Right(true);
    } catch (e, stack) {
      return Left(
        SomeFailure.value(
          error: e,
          stack: stack,
          tag: 'Work(sendRespond)',
          tagKey: ErrorText.repositoryKey,
          data: 'Employee Respond Model: $respond| ${file.getErrorData}',
        ),
      );
    }
  }
}
