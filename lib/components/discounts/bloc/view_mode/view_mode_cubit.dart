import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/constants/config.dart';

enum ViewMode { grid, list }

@Injectable(env: [Config.web])
class ViewModeCubit extends Cubit<ViewMode> {
  ViewModeCubit() : super(ViewMode.list);

  void setGridView() => emit(ViewMode.grid);
  void setListView() => emit(ViewMode.list);
}
