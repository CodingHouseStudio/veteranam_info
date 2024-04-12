import 'package:flutter/cupertino.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks(
  [
    MockSpec<IHomeRepository>(),
    MockSpec<IFeedbackRepository>(),
    MockSpec<FirestoreService>(),
  ],
)
void load() => debugPrint('loaded');
