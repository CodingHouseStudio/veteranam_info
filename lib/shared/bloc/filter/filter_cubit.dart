import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FilterCubit extends Cubit<List<dynamic>> {
  FilterCubit() : super([]);

  void change({
    required int index,
    required dynamic filterValue,
  }) {
    final filters = List<dynamic>.from(state);

    if (filters.length <= index) {
      filters.addAll(
        List.filled(index + 1 - filters.length, ''),
      );
    }

    filters.replaceRange(index, index + 1, [filterValue]);

    emit(filters);
  }

  void resetAllValues() {
    emit([]);
  }
}
