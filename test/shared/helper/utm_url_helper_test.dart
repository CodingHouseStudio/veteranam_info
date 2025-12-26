import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/helper/utm_url_helper.dart';

void main() {
  group('UtmUrlHelper.withDiscountUtm', () {
    test('returns trimmed empty string as-is', () {
      expect(UtmUrlHelper.withUtm(rawUrl: '   ', campaign: 'discount'), '');
    });

    test('returns original when cannot parse', () {
      const input = 'http://';
      final out = UtmUrlHelper.withUtm(rawUrl: input, campaign: 'discount');
      expect(out.isNotEmpty, true);
    });

    test('adds https scheme when missing', () {
      final out = UtmUrlHelper.withUtm(
        rawUrl: 'example.com/path',
        campaign: 'discount',
      );
      final uri = Uri.parse(out);

      expect(uri.scheme, 'https');
      expect(uri.host, 'example.com');
      expect(uri.path, '/path');

      expect(uri.queryParameters['utm_source'], 'veteranam.info');
      expect(uri.queryParameters['utm_medium'], 'referral');
      expect(uri.queryParameters['utm_campaign'], 'discount');
    });

    test('ignores non-http(s) schemes', () {
      const input = 'mailto:test@example.com?subject=Hello';
      final out = UtmUrlHelper.withUtm(rawUrl: input, campaign: 'discount');

      expect(out, Uri.parse(input).toString());
    });

    test('preserves existing query params (single value)', () {
      final out = UtmUrlHelper.withUtm(
        rawUrl: 'https://example.com?a=1&b=2',
        campaign: 'discount',
      );
      final uri = Uri.parse(out);

      expect(uri.queryParameters['a'], '1');
      expect(uri.queryParameters['b'], '2');
      expect(uri.queryParameters['utm_source'], 'veteranam.info');
    });

    test('preserves multi-value params', () {
      final out = UtmUrlHelper.withUtm(
        rawUrl: 'https://example.com?a=1&a=2',
        campaign: 'discount',
      );
      final uri = Uri.parse(out);

      expect(uri.queryParametersAll['a'], ['1', '2']);
      expect(uri.queryParameters['utm_source'], 'veteranam.info');
    });

    test('does not override existing utm params', () {
      final out = UtmUrlHelper.withUtm(
        rawUrl: 'https://example.com?utm_source=google&utm_campaign=old',
        campaign: 'discount',
      );
      final uri = Uri.parse(out);

      expect(uri.queryParameters['utm_source'], 'google');
      expect(uri.queryParameters['utm_campaign'], 'old');
      expect(uri.queryParameters['utm_medium'], 'referral');
    });

    test('uses provided campaign when utm_campaign absent', () {
      final out = UtmUrlHelper.withUtm(
        rawUrl: 'https://example.com',
        campaign: 'funds',
      );
      final uri = Uri.parse(out);

      expect(uri.queryParameters['utm_campaign'], 'funds');
    });
  });
}
