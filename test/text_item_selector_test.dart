import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_item_selector/text_item_selector.dart';

void main() {
  Widget makeWidgetTestable(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('verify index changes', (WidgetTester tester) async {
    int activeIndex = 0;
    await tester.pumpWidget(makeWidgetTestable(
      ItemSelectorBar(
        activeIndex: activeIndex,
        items: ["Item One", "Item Two"],
        onTap: (int index) => activeIndex = index,
      ),
    ));
    await tester.tap(find.byKey(Key("text-item-1")));
    await tester.pumpAndSettle();
    expect(activeIndex, activeIndex = 1);
    await tester.tap(find.byKey(Key("text-item-0")));
    await tester.pumpAndSettle();
    expect(activeIndex, activeIndex = 0);
  });
}
