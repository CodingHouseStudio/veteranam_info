enum LoadingStatus { initial, loading, loaded, error, listLoadedFull }

//enum EvaluationEnum { like, dislike, smile, none }

class FilterItem {
  FilterItem(this.value, {this.number = 1});

  final dynamic value;
  int number;
}

enum UrlEnum {
  shareError,
  linkError,
  copyError,
  error,
  copySucceed,
}
