import 'package:bloc_test/bloc_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/bloc/bloc.dart';

class MockHomeWatcherBloc extends MockBloc<HomeWatcherEvent, HomeWatcherState>
    implements HomeWatcherBloc {}

class MockFeedbackBloc extends MockBloc<FeedbackEvent, FeedbackState>
    implements FeedbackBloc {}
