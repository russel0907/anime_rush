import 'package:flutter_test/flutter_test.dart';
import 'package:anime_rush/app.dart';

void main() {
  testWidgets('App renders login page', (WidgetTester tester) async {
    await tester.pumpWidget(const AnimeRushApp());
    expect(find.text('SIGN UP'), findsOneWidget);
  });
}
