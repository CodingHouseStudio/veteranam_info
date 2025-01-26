import 'package:veteranam/components/news_card/bloc/news_card_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

late IInformationRepository mockInformationRepository;
void newsCardTestWidgetRegister() {
  mockInformationRepository = MockIInformationRepository();

  registerFactory(
    () => NewsCardWatcherBloc(
      informationRepository: mockInformationRepository,
    ),
  );
}
