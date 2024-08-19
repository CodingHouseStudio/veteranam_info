import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@injectable
class MobOfflineModeCubit extends Cubit<MobMode> {
  MobOfflineModeCubit({
    required FirestoreService firestoreService,
  })  : _firestoreService = firestoreService,
        super(MobMode.offline);
  final FirestoreService _firestoreService;
  void started() {
    emit(_firestoreService.offlineMode);
  }

  void switchMode() {
    emit(_firestoreService.switchOfflineMode);
  }
}
