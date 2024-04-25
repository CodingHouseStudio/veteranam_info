import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IWorkRepository)
class WorkRepository implements IWorkRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  @override
  Future<Either<SomeFailure, List<WorkModel>>> getWorks() async {
    try {
      final workItems = await _firestoreService.getWorks();
      return Right(workItems);
    } on Exception catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  void addMockWorks() {
    for (var i = 0; i < 5; i++) {
      _firestoreService.addWork(
        WorkModel(
          id: DateTime.now().millisecond.toString(),
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
}
