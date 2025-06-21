import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static navigateToWidget(Widget widget) async {
    String? x = await Navigator.of(navKey.currentContext!).push(
      MaterialPageRoute(
        builder: (ctx) {
          return widget;
        },
      ),
    );
    print(x);
    return x;
  }

  static popRoute() {
    Navigator.of(navKey.currentContext!).pop();
  }

  static navigateToWidgetWithReplacment(Widget widget) {
    Navigator.of(navKey.currentContext!).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) {
          return widget;
        },
      ),
    );
  }
}
