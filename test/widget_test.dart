import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:proximity_chat/main.dart';

void main() {
  testWidgets('Glance shows onboarding when no profile exists', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const GlanceApp());

    await tester.pumpAndSettle();

    expect(find.text('Welcome to Glance'), findsOneWidget);

    expect(find.text('Display name'), findsOneWidget);

    expect(find.text('Continue'), findsOneWidget);
  });
}
