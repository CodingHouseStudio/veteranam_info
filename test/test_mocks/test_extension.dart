import 'package:flutter_test/flutter_test.dart';

extension TesterExtension on WidgetTester {
  Future<void> tapOnTextCustom({
    required String text,
    String? englishText,
  }) async {
    final link = find.textRange.ofSubstring(text).first;

    try {
      if (englishText != null) {
        if (find.textContaining(text).evaluate().isNotEmpty) {
          await ensureVisible(find.textContaining(text).first);

          await tapOnText(link);
        } else {
          final linkEnglish = find.textRange.ofSubstring(englishText).first;

          await ensureVisible(find.textContaining(englishText).first);

          await tapOnText(linkEnglish);
        }
      } else {
        await ensureVisible(find.textContaining(text).first);

        await tapOnText(link);
      }
    } catch (e) {
      if (!e.toString().contains(
            'Finder specifies a TextRange that can not receive pointer events.',
          )) //this error is sometimes related to the size of the text
      {
        rethrow;
      }
    }
  }
}
