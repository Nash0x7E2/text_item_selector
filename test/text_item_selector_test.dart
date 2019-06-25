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
  testWidgets('verify text style changes', (WidgetTester tester) async {
    int activeIndex = 0;
    final initialStyle = TextStyle(color: Colors.blue, fontSize: 14);
    final animatedStyle = TextStyle(color: Colors.red, fontSize: 16);
    await tester.pumpWidget(makeWidgetTestable(
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          return ItemSelectorBar(
            activeIndex: activeIndex,
            items: ["Item One", "Item Two"],
            itemTextStyle: ItemTextStyle(
              initialStyle: initialStyle,
              selectedStyle: animatedStyle,
            ),
            onTap: (int index) {
              setState(() => activeIndex = index);
            },
          );
        },
      ),
    ));

    final itemOneFinder = find.text('Item One');
    Text firstItem = tester.firstWidget(itemOneFinder);
    expect(firstItem.style, animatedStyle);
    final itemTwoFinder = find.text('Item Two');
    Text secondItem = tester.firstWidget(itemTwoFinder);
    expect(secondItem.style, initialStyle);
    await tester.tap(itemTwoFinder);
    await tester.pumpAndSettle();
    firstItem = tester.firstWidget(itemOneFinder);
    secondItem = tester.firstWidget(itemTwoFinder);
    expect(secondItem.style, animatedStyle);
    expect(firstItem.style, initialStyle);
  });
}
