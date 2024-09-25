import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton(
  as: IInvestorsRepository, env: [Config.user],
  // signalsReady: true,
)
class InvestorsRepository implements IInvestorsRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
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
    } on FirebaseException catch (e, stack) {
      return Left(GetFailur.fromCode(error: e, stack: stack).status);
    } catch (e, stack) {
      return Left(SomeFailure.serverError(error: e, stack: stack));
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
