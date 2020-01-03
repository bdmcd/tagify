import 'package:flutter/material.dart';
import 'package:tagify/core/text/label.dart';

class LabelBody extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final TextOverflow overflow;
  final int maxLines;
  final Color color;

  LabelBody({
    this.text = "",
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Label(
      text: this.text,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      overflow: this.overflow,
      maxLines: this.maxLines,
      color: this.color,

      style: Theme.of(context).textTheme.body1.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
