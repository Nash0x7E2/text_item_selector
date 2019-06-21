import 'package:flutter/material.dart';
import 'package:text_item_selector/text_item_selector/item_text_style.dart';

class Item extends StatefulWidget {
  const Item({
    Key key,
    @required this.name,
    @required this.index,
    @required this.activeIndex,
    @required this.style,
    @required this.onTap,
    @required this.indicatorRadius,
    @required this.indicatorSpacing,
    @required this.indicatorColor,
  }) : super(key: key);
  final String name;
  final int index;
  final int activeIndex;
  final ItemTextStyle style;
  final ValueChanged<int> onTap;
  final double indicatorRadius;
  final double indicatorSpacing;
  final Color indicatorColor;

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with SingleTickerProviderStateMixin {
  bool _isSelected;
  Animation<TextStyle> _textStyle;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.activeIndex == widget.index;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: _isSelected ? 1.0 : 0.0,
    );

    _textStyle = TextStyleTween(
      begin: widget.style.initialStyle,
      end: widget.style.selectedStyle,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(Item oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = widget.activeIndex == widget.index;
    animateSelected();
  }

  void animateSelected() {
    if (_isSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.name,
              style: _textStyle.value,
            ),
            CustomPaint(
              painter: _CirclePainter(
                radius: widget.indicatorRadius,
                animation: _controller,
                verticalSpacing: widget.indicatorSpacing,
                circleColor: widget.indicatorColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter({
    @required this.radius,
    @required this.animation,
    this.verticalSpacing,
    this.circleColor,
  }) : super(repaint: animation);
  final double radius;
  final Animation<double> animation;
  final double verticalSpacing;
  final Color circleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = circleColor;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2 + verticalSpacing),
      radius * animation.value,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => oldDelegate.animation != animation;
}
