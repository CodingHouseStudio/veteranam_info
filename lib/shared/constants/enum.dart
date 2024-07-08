enum LoadingStatus { initial, loading, loaded, error, listLoadedFull }

//enum EvaluationEnum { like, dislike, smile, none }

class FilterItem {
  FilterItem(this.value);

  final String value;
  late int number = 1;
}
