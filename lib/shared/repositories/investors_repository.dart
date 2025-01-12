// import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: IInvestorsRepository)
class InvestorsRepository implements IInvestorsRepository {
  InvestorsRepository({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;
  final FirestoreService _firestoreService;
  @override
  Future<Either<SomeFailure, List<FundModel>>> getFunds(
      //   {
      //   List<String>? reportIdItems,
      // }
      ) async {
    try {
      final fundItems = await _firestoreService.getFunds(
          //reportIdItems
          );
      return Right(fundItems);
    } catch (e, stack) {
      return Left(
        SomeFailure.value(
          error: e,
          stack: stack,
          tag: 'Investors(getFunds)',
          tagKey: ErrorText.repositoryKey,
        ),
      );
    }
  }

  @override
  void addMockFunds() {
    for (var i = 0; i < 5; i++) {
      _firestoreService.addFund(
        KMockText.fundModel.copyWith(
          id: '${ExtendedDateTime.id}$i',
        ),
      );
    }
  }
}
