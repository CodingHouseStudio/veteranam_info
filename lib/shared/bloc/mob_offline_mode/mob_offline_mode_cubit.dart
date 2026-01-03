import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Injectable(env: [Config.mobile])
class MobOfflineModeCubit extends Cubit<MobMode> {
  MobOfflineModeCubit({
    required FirestoreService firestoreService,
  })  : _firestoreService = firestoreService,
        super(MobMode.offline) {
    _started();
  }
  final FirestoreService _firestoreService;
  void _started() {
    emit(_firestoreService.offlineMode);
  }

  void switchMode() {
    emit(_firestoreService.switchOfflineMode);
  }
}
