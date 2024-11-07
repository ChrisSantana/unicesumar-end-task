import 'package:flutter/material.dart';
import 'package:task_end/core/library/injection_container.dart';
import 'package:task_end/core/service/app_service.dart';
import 'package:task_end/features/task/presentation/pages/task_page.dart';

final class RouteGeneratorHelper {
  static String get location => _location;
  static String _location = kInitial;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    _location = settings.name ?? kInitial;
    switch (settings.name) {
      case kInitial:
        return createRoutePage(const TaskPage());
      default:
        return createRouteError();
    }
  }

  static PageRoute createRoutePage(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }

  static Route<dynamic> createRouteError() {
    const String msg = 'Error Route';
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text(msg),
          ),
        );
      },
    );
  }

  static const String kInitial = '/';

  static void onRouteInitialization(String route) {
    if (route.isNotEmpty) getIt<IAppService>().navigateNamedReplacementTo(route);
  }
}
