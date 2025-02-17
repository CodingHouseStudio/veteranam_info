import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/text/text_constants.dart';
import 'package:veteranam/shared/models/company_model.dart';
import 'package:veteranam/shared/models/user_model.dart';

extension StringExtension on String {
  bool get isUrlValid {
    const urlPattern = r'(https?://[^\s]+)';
    final regex = RegExp(
      urlPattern,
      caseSensitive: false,
    );
    return regex.hasMatch(this);
  }

  int compareUkrain(String b) {
    final minLength = length < b.length ? length : b.length;

    for (var i = 0; i < minLength; i++) {
      final aChar = this[i].toLowerCase();
      final bChar = b[i].toLowerCase();

      final aIndex = aChar._ukraineIndex;
      final bIndex = bChar._ukraineIndex;

      if (aIndex != bIndex) {
        return aIndex - bIndex;
      }
    }

    return length - b.length;
  }

  int get _ukraineIndex => KAppText.ukrainianAlphabet.indexOf(this);
  String get getImageUrl //({bool? highQuality})
  {
    if ((Config.isProduction && Config.isReleaseMode) || !Config.isWeb) {
      final url = Config.isWeb ? Uri.base.origin : 'https://veteranam.info';
      return '$url$_urlPrefix$this';
    } else {
      return this;
    }
  }

  String get _urlPrefix //({bool? highQuality})
  {
    // widget.size == null
    // ?
    const quality = '100'; // highQuality ?? false ? '100' : '85';
    const format = 'auto'; // KPlatformConstants.isWebSaffari ? 'jpeg' : 'auto';
    return '/cdn-cgi/image/quality=$quality,format=$format/';
  }
  // : '/cdn-cgi/image/${Config.isWeb ? 'quality=100' : 'quality=85'}'
  //     ',width=${widget.size! * 10},${widget.size! * 10}/';
}

extension UserExtensions on User {
  String? get firstName => name?.split(' ').first;

  String? get lastName => name?.split(' ').last;
}

extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;
  static String? _id;

  static DateTime get current => _customTime ?? DateTime.now().toUtc();

  static String get id =>
      _id ?? DateTime.now().toLocal().microsecondsSinceEpoch.toString();

  static String idIfExistNull(String? valueId) => valueId ?? id;

  @visibleForTesting
  static set current(DateTime? customTime) => _customTime = customTime;

  @visibleForTesting
  static set id(String? customId) => _id = customId;

  String get localeTime => toLocal().toString().split(' ')[0];
}

extension CompanyModelExtension on CompanyModel {
  bool get isAdmin => id == KAppText.adminCompanyID;
}
