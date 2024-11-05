import 'package:flutter/services.dart';
import 'package:task_end/core/bloc/factory_bloc.dart';
import 'package:task_end/core/library/injection_container.dart' as injector;
import 'package:task_end/core/library/route_generator_helper.dart';
import 'package:task_end/core/library/theme_helper.dart';
import 'package:task_end/core/library/util_text.dart';

void main() {
  _ConfigureModeUi.apply();
  runApp(const MypApp());
}

class MypApp extends StatelessWidget {
  const MypApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UtilText.labelAppName,
      theme: ThemeHelper.theme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGeneratorHelper.generateRoute,
      navigatorKey: injector.getIt<IAppService>().navigatorKey,
    );
  }
}

final class _ConfigureModeUi {
  static void apply() {
    injector.init();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ThemeHelper.transparentColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
