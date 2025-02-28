import 'package:flutter_test/flutter_test.dart';

extension TesterExtension on WidgetTester {
  Future<void> tapOnTextCustom({
    required String text,
    String? englishText,
    int index = 0,
    bool last = false,
  }) async {
    final linkItems = find.textRange.ofSubstring(text);
    final link = last ? linkItems.last : linkItems.at(index);

    try {
      if (englishText != null) {
        if (find.textContaining(text).evaluate().isNotEmpty) {
          final textItems = find.textContaining(text);
          await ensureVisible(last ? textItems.last : textItems.at(index));

          await tapOnText(link);
        } else {
          final linkEnglishItems = find.textRange.ofSubstring(englishText);
          final linkEnglish =
              last ? linkEnglishItems.last : linkEnglishItems.at(index);

          final textItems = find.textContaining(englishText);

          await ensureVisible(last ? textItems.last : textItems.at(index));

          await tapOnText(linkEnglish);
        }
      } else {
        final textItems = find.textContaining(text);
        await ensureVisible(last ? textItems.last : textItems.at(index));

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
