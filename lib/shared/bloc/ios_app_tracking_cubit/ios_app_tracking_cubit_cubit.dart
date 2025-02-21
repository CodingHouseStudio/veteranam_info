import 'package:app_tracking_transparency/app_tracking_transparency.dart'
    show TrackingStatus;
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Injectable(env: [Config.mobile])
class IosAppTrackingCubit extends Cubit<TrackingStatus?> {
  IosAppTrackingCubit({
    required IosAppTrackingRepository iosAppTrackingRepository,
  })  : _iosAppTrackingRepository = iosAppTrackingRepository,
        super(null) {
    _getStatus();
  }
  final IosAppTrackingRepository _iosAppTrackingRepository;

  Future<void> _getStatus() async {
    final result = await _iosAppTrackingRepository.getStatus();
    result.fold(
      (l) => emit(null),
      emit,
    );
  }

  Future<void> requestTrackingAuthorization() async {
    final result =
        await _iosAppTrackingRepository.requestTrackingAuthorization();
    result.fold(
      (l) => emit(null),
      emit,
    );
  }
}
