import 'package:flutter_test/flutter_test.dart';
import 'package:proximity_chat/main.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ProximityChatApp());

    expect(find.text('3 people nearby'), findsOneWidget);
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Sam'), findsOneWidget);
    expect(find.text('Unknown'), findsOneWidget);
  });
}
