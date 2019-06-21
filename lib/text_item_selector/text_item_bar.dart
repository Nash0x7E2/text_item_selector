library text_item_selector;

import 'package:flutter/material.dart';
import 'package:text_item_selector/text_item_selector/item.dart';
import 'package:text_item_selector/text_item_selector/item_text_style.dart';

class ItemSelectorBar extends StatelessWidget {
  const ItemSelectorBar({
    Key key,
    @required this.activeIndex,
    @required this.onTap,
    @required this.items,
    this.itemTextStyle = const ItemTextStyle(
      initialStyle: TextStyle(color: Colors.grey, fontSize: 14),
      selectedStyle: TextStyle(color: Colors.black, fontSize: 14),
    ),
    this.itemPadding = const EdgeInsets.all(8.0),
    this.indicatorRadius = 4.0,
    this.indicatorColor = Colors.redAccent,
    this.indicatorSpacing = 5.0,
    this.backgroundColor,
  })  : assert(activeIndex != null),
        assert(onTap != null),
        assert(items != null && items.length >= 1),
        assert(itemTextStyle != null),
        assert(itemPadding != null),
        assert(indicatorRadius != null),
        assert(indicatorColor != null),
        assert(indicatorSpacing != null),
        super(key: key);

  final int activeIndex;
  final ValueChanged<int> onTap;
  final List<String> items;
  final EdgeInsetsGeometry itemPadding;
  final ItemTextStyle itemTextStyle;
  final double indicatorRadius;
  final double indicatorSpacing;
  final Color indicatorColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Theme.of(context).primaryColor,
      child: Row(
        children: [
          for (int index = 0; index < items.length; index++)
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(index),
                child: Padding(
                  padding: itemPadding,
                  child: Item(
                    index: index,
                    name: items[index],
                    activeIndex: activeIndex,
                    style: itemTextStyle,
                    onTap: onTap,
                    indicatorColor: indicatorColor,
                    indicatorRadius: indicatorRadius,
                    indicatorSpacing: indicatorSpacing,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
