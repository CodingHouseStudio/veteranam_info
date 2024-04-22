import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IInvestorsRepository)
class InvestorsRepository implements IInvestorsRepository {
  final FirestoreService _firestoreService = GetIt.I.get<FirestoreService>();
  @override
  Future<Either<SomeFailure, List<FundModel>>> getFunds() async {
    try {
      final fundItems = await _firestoreService.getFunds();
      return Right(fundItems);
    } on Exception catch (e) {
      return Left(GetFailur.fromCode(e).status);
    } catch (e) {
      return const Left(SomeFailure.serverError());
    }
  }

  @override
  void addMockFunds() {
    for (var i = 0; i < 5; i++) {
      _firestoreService.addFund(
        FundModel(
          id: DateTime.now().millisecond.toString(),
          title: KMockText.donateCardTitle,
          subtitle: KMockText.donateCardSubtitle,
          link: '',
        ),
      );
    }
  }
}
