import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FilterCubit extends Cubit<List<dynamic>> {
  FilterCubit() : super([]);

  // List<dynamic> initialValue({
  //   required List<dynamic> initialFiltersItems,
  //   required dynamic defaultFilterValue,
  // }) {
  //   if (initialFiltersItems.first is List) {
  //     for (final list in initialFiltersItems) {
  //       if (!(list as List).contains(defaultFilterValue)) {
  //         list.insert(0, defaultFilterValue);
  //       }
  //     }
  //   } else {
  //     if (initialFiltersItems.contains(defaultFilterValue)) {
  //       initialFiltersItems.add(defaultFilterValue);
  //     }
  //   }

  //   emit(
  //     List.generate(
  //       initialFiltersItems.length,
  //       (index) => initialFiltersItems.elementAt(index) is List
  //           ? (initialFiltersItems.elementAt(index) as List).first
  //           : initialFiltersItems.elementAt(index),
  //     ),
  //   );
  //   return initialFiltersItems;
  // }

  void change({
    required int index,
    required dynamic filterValue,
  }) {
    final filters = List<dynamic>.from(state);

    if (filters.length <= index) {
      filters.addAll(
        List.filled(index + 1, ''),
      );
    }

    filters.replaceRange(index, index + 1, [filterValue]);

    emit(filters);
  }

  void resetAllValues() {
    emit([]);
  }
}
