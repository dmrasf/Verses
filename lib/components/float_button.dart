import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';

class FloatButton extends StatelessWidget {
  final Widget child;
  final Function _press;
  final int themeId;
  FloatButton(this.child, this._press, this.themeId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _press,
      child: Container(
        height: 40,
        width: 40,
        child: this.child,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeColor[this.themeId]['textColor'],
        ),
      ),
    );
  }
}
