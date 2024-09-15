import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

enum LoadingStatus { initial, loading, loaded, error, listLoadedFull }

//enum EvaluationEnum { like, dislike, smile, none }

class FilterItem {
  FilterItem(this.value, {this.number = 1, this.valueEN});

  final dynamic value;
  final dynamic valueEN;
  final int number;

  String getString(BuildContext context) =>
      (context.isEnglish && valueEN != null ? valueEN : value).toString();
}

enum UrlEnum {
  shareError,
  linkError,
  copyError,
  error,
  copyEmailSucceed,
  copyLinkSucceed,
}

enum CategoryEnum { all }

class DropDownItem {
  DropDownItem({
    required this.text,
    required this.action,
    required this.key,
  });

  final String text;
  final VoidCallback? action;
  final Key key;
}
