import 'package:flutter/material.dart';
import 'package:tagify/core/text/label.dart';
import 'package:tagify/core/theme.dart';

class LabelSubtitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final TextOverflow overflow;
  final int maxLines;
  final Color color;

  LabelSubtitle({
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
      color: this.color ?? TagifyTheme.of(context).foreground2,

      style: Theme.of(context).textTheme.subtitle.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }
}