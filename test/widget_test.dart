import 'package:flutter_test/flutter_test.dart';
import 'package:proximity_chat/main.dart';

void main() {
  testWidgets('Glance shows onboarding for a new user', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GlanceApp());

    expect(find.text('Welcome to Glance'), findsOneWidget);

    expect(find.text('Display name'), findsOneWidget);

    expect(find.text('Continue'), findsOneWidget);
  });
}
