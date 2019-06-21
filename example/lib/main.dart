import 'package:flutter/material.dart';
import 'package:text_item_selector/text_item_selector.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _activeItem = 0;
  PageController _pageController;
  List<Widget> pages = [
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.pink,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: pages,
            ),
          ),
          Expanded(
            flex: 1,
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
          )
        ],
      ),
    ));
  }
}
