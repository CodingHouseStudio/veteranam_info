import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

@Singleton(as: IInformationRepository)
class InformationRepository implements IInformationRepository {
  final _controller = StreamController<List<InformationModel>>()..add([]);

  @override
  Stream<List<InformationModel>> getInformationItems() {
    return _controller.stream;
  }

  @override
  void addMockInformationItems() {
    final informationModelItems = <InformationModel>[];
    for (var i = 0; i < KMockText.tags.length; i++) {
      informationModelItems.add(
        InformationModel(
          id: DateTime.now().millisecond.toString(),
          title: KMockText.title,
          news: KMockText.cardData,
          date: DateTime.now(),
          image: i > KMockText.tags.length - 2 ? KMockText.image : null,
          tags: KMockText.tags.elementAt(i),
        ),
      );
    }
    _controller.add(informationModelItems);
  }
}
