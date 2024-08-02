import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@injectable
class AdvancedFilterMobCubit extends Cubit<List<int>> {
  AdvancedFilterMobCubit() : super([]);
  void started(List<int> initialList) => emit(initialList);
  void changeFilterList(int value) {
    final selectedFilters = state.checkValue(
      filterIndex: value,
      equalNumber: 2,
      largerNumber: 3,
    );
    emit(selectedFilters);
  }

  void reset() {
    emit([]);
  }
}
