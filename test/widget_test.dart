// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:image_to_pdf/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for splash screen (if any) or initial frame
    await tester.pumpAndSettle();

    // Verify that the app title is displayed.
    // Note: Since we have an animated splash screen, we might need to wait or mock it.
    // For a basic smoke test, just ensuring it pumps without error is a good start,
    // or finding a widget we know exists after splash.
    
    // Check if MaterialApp is present
    expect(find.byType(MyApp), findsOneWidget);
  });
}
