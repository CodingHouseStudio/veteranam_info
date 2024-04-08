import 'package:flutter/cupertino.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks(
  [
    MockSpec<IHomeRepository>(),
    MockSpec<HomeRepository>(),
  ],
)
void load() => debugPrint('loaded');
