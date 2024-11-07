import 'package:flutter/material.dart';

abstract interface class IAppService {
  Future<Object?>? navigateNamedTo(String routeName, {Object? arguments});
  Future<Object?>? navigateNamedReplacementTo(String routeName, {Object? arguments});
  Future<Object?>? navigatePushNamedAndRemoveUntil(String routeName, {bool animated = false});
  Future<Object?>? navigatePushReplecementTo(Widget widget, {bool animated = false});
  Future<Object?>? navigateTo(Widget widget, {bool animated = false});
  Future<Object?>? navigateReplacementTo(Widget widget, {bool animated = false});
  Future<Object?>? navigatePushAndRemoveUntil(Widget widget, {bool animated = false});
  MaterialPageRoute pageRouteDefault(Widget widget);
  PageRouteBuilder pageRouteAnimated(Widget widget);
  void navigatePop([Object? object]);
  BuildContext? get context;
  GlobalKey<NavigatorState> get navigatorKey;
}

final class AppService implements IAppService {
  final GlobalKey<NavigatorState> _navigatorKey;

  const AppService(this._navigatorKey);

  @override
  Future<dynamic> navigateNamedTo(String routeName, {Object? arguments}) async {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> navigateNamedReplacementTo(String routeName, {Object? arguments}) async {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> navigatePushNamedAndRemoveUntil(String routeName, {bool animated = false}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (_) {
      return false;
    });
  }

  @override
  Future<dynamic> navigatePushReplecementTo(Widget widget, {bool animated = false}) async {
    return navigatorKey.currentState?.pushReplacement(!animated ? pageRouteDefault(widget) : pageRouteAnimated(widget));
  }

  @override
  Future<dynamic> navigateTo(Widget widget, {bool animated = false}) async {
    return navigatorKey.currentState?.push(!animated ? pageRouteDefault(widget) : pageRouteAnimated(widget));
  }

  @override
  Future<dynamic> navigateReplacementTo(Widget widget, {bool animated = false}) async {
    return navigatorKey.currentState?.pushReplacement(!animated ? pageRouteDefault(widget) : pageRouteAnimated(widget));
  }

  @override
  Future<dynamic> navigatePushAndRemoveUntil(Widget widget, {bool animated = false}) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(!animated ? pageRouteDefault(widget) : pageRouteAnimated(widget), (_) {
      return false;
    });
  }

  @override
  void navigatePop([Object? object]) {
    return navigatorKey.currentState?.pop(object);
  }

  @override
  MaterialPageRoute pageRouteDefault(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }

  @override
  PageRouteBuilder pageRouteAnimated(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  BuildContext? get context => navigatorKey.currentState?.overlay?.context;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
