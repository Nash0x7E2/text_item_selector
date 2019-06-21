# Text Item Selector 
![](demo/demo.gif)

#What is Text Item Selector 
Text Item Selector is a simple package inspired by `BottomNaviagtionBar` which allows you to specify a list of `String`s to be used as items. Items can be customized using `ItemTextStyle`, a class which allows you to specify the `TextStyle` for active and inactive items. When an item is tapped, a callback is triggered providing you with the index of the tapped item. When the item is changed, the text style animates and the circle indicator at the bottom of the selected item shrinks and grows to the new item. 

## Installing 

```yaml
dependencies:
  text_item_selector: any
```

Import the package
```dart
import 'package:text_item_selector/text_item_selector.dart';
```

## Using 
Like `BottomNavigationBar`, `Text Item Selector` is optimized for small number of items. 

In a `StatefulWidget`, create `ItemSelectorBar` and pass it the active index and list of items. 
```dart
child: ItemSelectorBar(
    backgroundColor: Colors.white,
    activeIndex: _activeItem,
    items: <String>[
        'Page One',
        'Page Two',
    ],
    onTap: (int value) {
        setState(() {
            _activeItem = value;
        });
        _pageController.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.ease);
    },

    itemTextStyle: ItemTextStyle(
        initialStyle: TextStyle(color: Colors.blue, fontSize: 16.0),
        selectedStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
    ),
),
```

For a full example please see `example/` 