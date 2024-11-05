final class ComumConstant {
  static const int kSecondsTimeoutDefault = 30;
  static const int kAttemptRefreshTokenLimit = 1;
  static const String kModeEnvironmentSupport = 'S';
  static const String kModeEnvironmentStaging = 'T';
}

final class HttpConstant {
  static const int kSuccess = 200;
  static const int kSuccessNoContent = 204;
  static const int kSuccessLimit = 299;
  static const int kInvalidOperation = 400;
  static const int kExpiredToken = 401;
  static const int kNotPermission = 403;
  static const int kNotFound = 404;
  static const int kDefaultError = 500;
}

final class TableRelationalNameConstant {
  static const String kUseTerms = 'use_terms';
}
