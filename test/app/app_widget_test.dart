import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/app/app.dart';
import 'package:kozak/shared/shared.dart';

void main() {
  group('${ScreenName.app} Page', () {
    testWidgets('renders initial', (tester) async {
      await tester.pumpWidget(const App());

      expect(find.byKey(KWIdgetkeys.appKeys.screen), findsOneWidget);
    });
  });
}
