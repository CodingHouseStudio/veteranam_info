import 'package:flutter/cupertino.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks(
  [
    MockSpec<IHomeRepository>(),
    MockSpec<IInformationRepository>(),
    MockSpec<IFeedbackRepository>(),
    MockSpec<FirestoreService>(),
    MockSpec<IInvestorsRepository>(),
  ],
)
void load() => debugPrint('loaded');
