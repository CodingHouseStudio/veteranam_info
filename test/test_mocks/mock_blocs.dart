import 'package:flutter/material.dart';
import 'package:kozak/shared/bloc/bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks(
  [
    MockSpec<FilterCubit>(),
  ],
)
void loadBlocs() => debugPrint('loaded');
