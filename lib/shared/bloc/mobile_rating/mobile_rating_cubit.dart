import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Singleton()
class MobileRatingCubit extends Cubit<void> {
  MobileRatingCubit({
    required MobileRatingRepository mobileRatingRepository,
  })  : _mobileRatingRepository = mobileRatingRepository,
        super(false);

  final MobileRatingRepository _mobileRatingRepository;

  void started() {
    _mobileRatingRepository.showRatingDialog();
  }
}
