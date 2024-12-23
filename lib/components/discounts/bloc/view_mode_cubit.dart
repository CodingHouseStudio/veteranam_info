import 'package:flutter_bloc/flutter_bloc.dart';

enum ViewMode { grid, list }

class ViewModeCubit extends Cubit<ViewMode> {
  ViewModeCubit() : super(ViewMode.list);

  void setGridView() => emit(ViewMode.grid);
  void setListView() => emit(ViewMode.list);
}
