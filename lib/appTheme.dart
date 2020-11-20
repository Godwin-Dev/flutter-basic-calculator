import 'package:flutter/cupertino.dart';

class AppTheme extends ChangeNotifier {

  String _theme;

  AppTheme(this._theme);

  getTheme()=>_theme;

  void changeTheme(String changedTheme){
    _theme = changedTheme;
    notifyListeners();
  }

}