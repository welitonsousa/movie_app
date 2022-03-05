import 'package:flutter/material.dart';

class AppRating extends StatelessWidget {
  final double value;
  final int quantityStars;
  final int maxValue;
  const AppRating(
      {Key? key,
      required this.value,
      this.quantityStars = 5,
      this.maxValue = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _items,
    );
  }

  List<Widget> get _items {
    final list = <Widget>[];
    for (int index = 1; index <= quantityStars; index++) {
      list.add(Icon(
        Icons.star,
        size: 18,
        color: index <= ((value / (maxValue / quantityStars))).round()
            ? Colors.yellow
            : null,
      ));
    }
    return list;
  }
}
