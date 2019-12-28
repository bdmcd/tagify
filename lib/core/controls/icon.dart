import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';
import 'package:tagify/core/theme.dart';

class Icon extends m.StatelessWidget {
  final m.IconData icon;
  final m.Color color;
  final m.Color highlightedColor;
  final double size;
  final String semanticLabel;
  final m.TextDirection textDirection;
  final bool highlighted;

  Icon(this.icon, {
    this.size,
    this.color,
    this.highlighted = false,
    this.highlightedColor,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  m.Widget build(m.BuildContext context) {
    final c = this.color ?? TagifyTheme.of(context).foreground;
    final hc = this.highlightedColor ?? TagifyTheme.of(context).primary;
    return m.Icon(
      this.icon,
      color: this.highlighted ? hc : c,
      size: this.size ?? 24,
      semanticLabel: this.semanticLabel,
      textDirection: this.textDirection,
    );
  }
}

class IconButton extends m.StatelessWidget {
  final m.Widget icon;
  final Function onPressed;
  final m.Color color;
  final m.Color highlightedColor;
  final m.Color disabledColor;
  final double iconSize;
  final bool highlighted;
  final bool disabled;

  IconButton({
    @m.required this.icon,
    @m.required this.onPressed,
    this.color,
    this.highlightedColor,
    this.disabledColor,
    this.iconSize,
    this.highlighted = false,
    this.disabled = false,
  }) : assert(icon is! Icon);

  @override
  m.Widget build(m.BuildContext context) {
    return Consumer<TagifyTheme>(
      builder: (context, theme, _) {
        final c = this.color ?? theme.foreground;
        final dc = this.disabledColor ?? theme.disabled;
        final hc = this.highlightedColor ?? theme.tagifyDark;

        return m.IconButton(
          icon: this.icon,
          onPressed: this.onPressed,
          color: this.disabled ? dc : this.highlighted ? hc : c,
          highlightColor: this.highlightedColor,
          disabledColor: this.disabledColor,
          iconSize: this.iconSize ?? 24,
          splashColor: m.Colors.transparent,
        );
      }
    );
  }
}