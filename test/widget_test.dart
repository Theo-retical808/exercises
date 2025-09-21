// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgets_personilized/main.dart';

void main() {
  testWidgets('Task app loads and displays tasks', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskApp());

    // Verify that our app loads with the Tasks title.
    expect(find.text('Tasks'), findsOneWidget);
    
    // Verify that demo tasks are displayed.
    expect(find.text('Write unit tests'), findsOneWidget);
    expect(find.text('Refactor auth'), findsOneWidget);
    expect(find.text('Design review'), findsOneWidget);

    // Verify that the floating action button is present.
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Add task modal opens when FAB is tapped', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskApp());

    // Tap the floating action button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the modal opened with "Add Task" title.
    expect(find.text('Add Task'), findsOneWidget);
    expect(find.text('Create (UI only)'), findsOneWidget);
  });
}
