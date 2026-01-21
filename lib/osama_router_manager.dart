import "package:flutter/material.dart";

class osamaRouterManager {
  osamaRouterManagerRouterManager._();
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Future<T?> go<T>(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute<T>(builder: (_) => page),
    );
  }

  static Future<T?> goReplac<T, TO>(Widget page) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute<T>(builder: (_) => page),
    );
  }

  static Future<T?> goAndRemoveUntil<T>(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute<T>(builder: (_) => page),
          (_) => false,
    );
  }

  static Future<T?> goNamed<T>(String route, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(route, arguments: arguments);
  }

  static Future<T?> goReplaceNamed<T>(String route, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  static Future<T?> goNamedAndRemoveUntil<T>(
      String route, {
        Object? arguments,
      }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route,
          (_) => false,
      arguments: arguments,
    );
  }

  static void back<T>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }

  static void backTimes(int times) {
    for (int i = 0; i < times; i++) {
      if (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState!.pop();
      }
    }
  }
}
