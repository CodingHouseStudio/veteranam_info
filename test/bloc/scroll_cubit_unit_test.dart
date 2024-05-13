import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('${KScreenBlocName.scroll} ${KGroupText.cubit}', () {
    late ScrollCubit scrollCubit;
    setUp(() => scrollCubit = ScrollCubit());
    blocTest<ScrollCubit, ScrollController>(
      'emits [ScrollController] when init scroll',
      build: () => scrollCubit,
      act: (cubit) {
        cubit.initial();
      },
      expect: () => [
        isA<ScrollController>(),
      ],
    );
  });
}
