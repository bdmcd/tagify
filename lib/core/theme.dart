import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/model/album.dart';
import 'package:tagify/palette/palette_fetcher.dart';

class TagifyTheme extends ChangeNotifier {
  static TagifyTheme of(BuildContext context) => Provider.of<TagifyTheme>(context);

  Color _tagify;
  Color _tagifyLight;
  Color _tagifyDark;

  final Color primary = Color(0xFFF76B00);
  final Color washed = Color(0xFFFFE5DB);
  final Color darkened = Color(0xFFBD5200);
  
  final Color foreground = Color(0xFFF5F5F5);//Color(0xFF292929);
  final Color foreground2 = Color(0xFFE5E5E5);//Color(0xFF191919);

  final Color background = Color(0xFF222222);//Color(0xFFF5F5F5);
  final Color background2 = Color(0xFF191919);//Color(0xFFEEEEEE);

  final Color disabled = Color(0xCC999999);

  Color get tagify => _tagify ?? primary;
  Color get tagifyLight => _tagifyLight ?? washed;
  Color get tagifyDark => _tagifyDark ?? darkened;

  void setPalette(Album album) async {
    final palette = await PaletteFetcher.instance.getPalette(album);
    //TODO: sort by brightest, pick the best ones
    _tagify = palette?.vibrant?.withOpacity(1);
    _tagifyLight = palette?.lightMuted?.withOpacity(1);
    _tagifyDark = palette?.darkVibrant?.withOpacity(1);

    notifyListeners();
  }
}