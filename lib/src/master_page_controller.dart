//ignore_for_file:use_setters_to_change_properties

import 'package:flutter/material.dart';

/// Master Page Controller can change visible page.
/// This is useful when you use custom bottom navigation bar
class MasterPageController {
  Function(String pageName) _setVisible;
  final void Function(String activePageName) onActivePageChange;

  MasterPageController({this.onActivePageChange});

  void addListener({@required Function(String pageName) setVisible}) {
    _setVisible = setVisible;
  }

  void setVisible(String name) {
    if (onActivePageChange != null) {
      onActivePageChange(name);
    }
    _setVisible(name);
  }
}
