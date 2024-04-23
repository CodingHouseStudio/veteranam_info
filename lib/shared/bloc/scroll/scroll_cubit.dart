import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScrollCubit extends Cubit<ScrollController> {
  ScrollCubit() : super(ScrollController());
  void initial() {
    emit(ScrollController());
  }

  bool scrollUp() {
    emit(state..jumpTo(0));
    return true;
  }
}
