// coverage:ignore-file
import 'package:flutter/material.dart';

final class ThemeHelper {
  static const Color mainColor = Color.fromRGBO(254, 139, 22, 1);
  static const Color mainLightColor = Color.fromRGBO(255, 182, 102, 1);
  static const Color mainStrongerColor = Color.fromRGBO(255, 127, 9, 1);
  static const Color mainStrongerTransparentColor = Color.fromRGBO(255, 127, 9, 0.26);
  static const Color blackColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color grayDarkColor = Color.fromRGBO(43, 46, 33, 1);
  static const Color grayLightColor = Color.fromRGBO(175, 175, 175, 1);
  static const Color grayExtraLightColor = Color.fromRGBO(217, 217, 217, 1);
  static const Color disabledColor = Color.fromRGBO(120, 120, 120, 1);
  static const Color whiteColor = Colors.white;
  static const Color transparentColor = Colors.transparent;
  static const Color redColor = Color.fromRGBO(168, 41, 0, 1);
  static const Color captionColor = Color.fromRGBO(78, 78, 78, 1);
  static const Color borderColor = mainColor;
  static const Color buttonTextColor = blackColor;
  static const Color yellowColor = Color.fromRGBO(255, 196, 80, 1);
  static const Color backgroundColor = Color.fromRGBO(255, 249, 242, 1);
  static const Color positiveColor = Colors.green;
  static const Color sliderButtonMainOpaqueColor = Color.fromRGBO(255, 170, 87, 1.0);
  static const Color sliderButtonGrayLightColor = Color.fromRGBO(128, 128, 128, 1);
  static const Color alreadyAnswerContainerColor = Color.fromRGBO(255, 250, 245, 1);

  static const Color statusNotRealizedColor = Color.fromRGBO(168, 41, 0, 1);
  static const Color statusInProgressColor = Color.fromRGBO(255, 196, 80, 1);
  static const Color statusCompletedColor = Color.fromRGBO(3, 168, 0, 1);
  static const Color statusDisabledColor = Color.fromRGBO(84, 84, 84, 1);

  static Color get shadowColor => Colors.grey.withOpacity(0.5);
  static const Color timelineCompletedShadowColor = Color.fromRGBO(3, 168, 0, 0.33);
  static const Color timelineNotRealizedShadowColor = Color.fromRGBO(168, 41, 0, 0.5);
  static const Color timelineInProgressShadowColor = Color.fromRGBO(255, 196, 80, 0.55);

  static const double radiusCircularWithSixPixels = 6;
  static const double radiusCircularWithTenPixels = 10;
  static const double radiusCircularWithTwelvePixels = 12;
  static const double radiusCircularWithSixteenPixels = 16;

  static const MaterialColor materialColor = MaterialColor(
    0xFFFFC450,
    <int, Color>{
      50: Color.fromRGBO(254, 139, 22, .1),
      100: Color.fromRGBO(254, 139, 22, .2),
      200: Color.fromRGBO(254, 139, 22, .3),
      300: Color.fromRGBO(254, 139, 22, .4),
      400: Color.fromRGBO(254, 139, 22, .5),
      500: Color.fromRGBO(254, 139, 22, .6),
      600: Color.fromRGBO(254, 139, 22, .7),
      700: Color.fromRGBO(254, 139, 22, .8),
      800: Color.fromRGBO(254, 139, 22, .9),
      900: Color.fromRGBO(254, 139, 22, 1),
    },
  );

  static const gradientColors = [
    Color.fromRGBO(255, 104, 0, 1),
    Color.fromRGBO(254, 139, 22, 1),
    Color.fromRGBO(255, 182, 102, 1),
  ];

  static const grayGradientColors = [
    Color.fromRGBO(78, 78, 78, 1),
    Color.fromRGBO(108, 108, 108, 1.0),
    Color.fromRGBO(131, 131, 131, 1),
  ];

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(primary: materialColor),
      scaffoldBackgroundColor: backgroundColor,
      unselectedWidgetColor: mainColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: mainColor,
          foregroundColor: whiteColor,
          disabledForegroundColor: disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusCircularWithSixPixels),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: whiteColor,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 2,
          foregroundColor: transparentColor,
          disabledForegroundColor: disabledColor,
          side: const BorderSide(width: 2, color: mainColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusCircularWithSixPixels),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: mainColor,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(mainLightColor),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: backgroundColor,
        titleTextStyle: TextStyle(
          color: mainStrongerColor,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 3,
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(radiusCircularWithTwelvePixels),
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: whiteColor,
        unselectedLabelColor: whiteColor,
        indicatorColor: whiteColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.all(Radius.circular(radiusCircularWithTwelvePixels)),
          borderSide: BorderSide(
            width: 3,
            color: whiteColor,
            style: BorderStyle.solid,
          ),
          insets: EdgeInsets.only(bottom: 4),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: mainLightColor,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            transparentColor;
            if (states.contains(WidgetState.selected)) {
              return transparentColor.withOpacity(0.1);
            }
            return transparentColor;
          },
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: backgroundColor,
      ),
    );
  }
}

final class TextFieldHelper {
  static OutlineInputBorder outlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? ThemeHelper.blackColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
