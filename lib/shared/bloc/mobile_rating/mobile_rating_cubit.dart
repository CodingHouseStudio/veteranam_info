import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable(env: [Config.mobile])
class MobileRatingCubit extends Cubit<void> {
  MobileRatingCubit({
    required MobileRatingRepository mobileRatingRepository,
  })  : _mobileRatingRepository = mobileRatingRepository,
        super(false);

  final MobileRatingRepository _mobileRatingRepository;

  Future<void> showDialog() async {
    await _mobileRatingRepository.showRatingDialog();
  }
}
