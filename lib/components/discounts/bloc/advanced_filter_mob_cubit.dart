import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@injectable
class AdvancedFilterMobCubit extends Cubit<List<dynamic>> {
  AdvancedFilterMobCubit() : super([]);
  void started(List<dynamic> initialList) => emit(initialList);
  void changeFilterList(dynamic value) {
    final selectedFilters = state.checkValue(
      filterValue: value,
      equalValue: SubLocation.allStoresOfChain,
    );
    emit(selectedFilters);
  }

  void reset() {
    emit([]);
  }
}
