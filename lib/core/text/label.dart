import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/theme.dart';

export 'body.dart';
export 'body_bold.dart';
export 'caption.dart';
export 'headline.dart';
export 'title.dart';
export 'title_small.dart';
export 'subtitle.dart';

class Label extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final TextOverflow overflow;
  final int maxLines;
  final Color color;

  Label({
    this.text = "",
    this.style,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (this.color == null) {
      return Consumer<TagifyTheme>(
        builder: (context, theme, _) {
          return _buildText(
            style: this.style.copyWith(
              color: theme.foreground,
            ),
          );
        },
      ); 
    }

    return _buildText(
      style: this.style.copyWith(
        color: this.color,
      ),
    );
  }

  Text _buildText({TextStyle style}) {
    return Text(
      this.text,
      style: style ?? this.style,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      overflow: this.overflow,
      maxLines: this.maxLines,
    );
  }
}