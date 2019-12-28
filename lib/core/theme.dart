import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagifyTheme extends ChangeNotifier {
  static TagifyTheme of(BuildContext context) => Provider.of<TagifyTheme>(context);

  final Color primary = Color(0xFFF76B00);
  final Color washed = Color(0xFFFFE5DB);
  final Color darkened = Color(0xFFBD5200);
  
  final Color foreground = Color(0xFF292929);
  final Color foreground2 = Color(0xFF191919);

  final Color background = Color(0xFFF5F5F5);
  final Color background2 = Color(0xFFEEEEEE);

  final Color disabled = Color(0xCC999999);
}