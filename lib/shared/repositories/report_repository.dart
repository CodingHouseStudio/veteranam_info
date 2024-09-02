import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(
  as: IReportRepository,
  // signalsReady: true,
)
class ReportRepository implements IReportRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();

  @override
  Future<Either<SomeFailure, bool>> sendReport(ReportModel report) async {
    try {
      await _firestoreService.addReport(report);
      return const Right(true);
    } on FirebaseException catch (e, stack) {
      return Left(SendFailure.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }

  @override
  Future<Either<SomeFailure, List<ReportModel>>> getCardReportById({
    required CardEnum cardEnum,
    required String userId,
  }) async {
    try {
      final userDiscountsItems = await _firestoreService.getCardReportByUserId(
        cardEnum: cardEnum,
        userId: userId,
      );

      return Right(userDiscountsItems);
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
    }
  }
}
