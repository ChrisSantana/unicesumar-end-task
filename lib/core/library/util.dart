import 'dart:math';

final class Util {
  /// #region Config
  static const String extensionPNG = 'png';
  static const String extensionJPG = 'jpg';
  static const String extensionPDF = 'pdf';
  static const String directoryMedia = 'media';

  /// #region Internationalization
  static const String languageCode = 'pt';
  static const String countryCode = 'BR';
  static const String localeId = '${languageCode}_$countryCode';
  static const String localeUs = 'en_US';

  static String generateRandomId() {
    return Random().nextInt(100000).toString();
  }
}
