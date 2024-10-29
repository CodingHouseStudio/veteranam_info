enum LoadingStatus { initial, loading, loaded, error, listLoadedFull }

//enum EvaluationEnum { like, dislike, smile, none }

enum UrlEnum {
  shareError,
  linkError,
  copyError,
  error,
  copyEmailSucceed,
  copyLinkSucceed,
}

enum CategoryEnum { all }

enum AuthenticationStatus {
  unknown,
  anonymous,
  authenticated,
} //unauthenticated

enum MobMode {
  online,
  offline;

  bool get isOffline => this == MobMode.offline;
  MobMode get switchMode => isOffline ? MobMode.online : MobMode.offline;
}
