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
}

extension UserExtensions on User {
  String? get firstName => name?.split(' ').first;

  String? get lastName => name?.split(' ').last;
}
