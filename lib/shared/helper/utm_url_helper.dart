/// Helper for safely adding UTM parameters to URLs.
///
/// - Trims input.
/// - Accepts URLs with/without scheme (adds https:// if missing).
/// - Ignores non-http(s) schemes (e.g. mailto:, tg:, ftp:).
/// - Preserves existing query parameters (including multi-value params).
/// - Does NOT override existing UTM params if they already exist.
class UtmUrlHelper {
  static const String defaultSource = 'veteranam.info';
  static const String defaultMedium = 'referral';

  static String withUtm({
    required String rawUrl,
    required String campaign,
    String? source,
    String? medium,
  }) {
    final trimmed = rawUrl.trim();
    if (trimmed.isEmpty) return trimmed;

    var uri = Uri.tryParse(trimmed);
    if (uri == null) return trimmed;

    if (!uri.hasScheme) {
      uri = Uri.tryParse('https://$trimmed');
      if (uri == null) return trimmed;
    }

    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') return uri.toString();

    final qpAll = <String, List<String>>{
      for (final e in uri.queryParametersAll.entries)
        e.key: List<String>.from(e.value),
    }
      ..putIfAbsent('utm_source', () => <String>[source ?? defaultSource])
      ..putIfAbsent('utm_medium', () => <String>[medium ?? defaultMedium])
      ..putIfAbsent('utm_campaign', () => <String>[campaign]);

    final qpForReplace = qpAll.map(MapEntry<String, dynamic>.new);
    return uri.replace(queryParameters: qpForReplace).toString();
  }
}
