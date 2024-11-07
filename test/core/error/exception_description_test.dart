import 'package:flutter_test/flutter_test.dart';
import 'package:task_end/core/error/handler_exception_extension.dart' show ExceptionDescription;
import 'package:task_end/core/error/http_exception.dart';
import 'package:task_end/core/library/util_text.dart';

void main() {
  test('should valid the exception error', () async {
    expect(HttpNotFoundException().description(), UtilText.labelHttpNotFoundException);
    expect(HttpExpiredTokenException().description(), UtilText.labelHttpExpiredToken);
    expect(HttpInvalidOperationException().description(), UtilText.labelHttpInvalidOperation);
    expect(HttpNotPermissionException().description(), UtilText.labelHttpNotPermissionException);
    expect(HttpTimeoutException().description(), UtilText.labelHttpTimeoutException);
    expect(HttpInternetConnectionFailure().description(), UtilText.labelHttpInternetConnectionFailure);
    expect(HttpError().description(), UtilText.labelHttpDefault);
    expect(Exception().description(), UtilText.labelHttpGenericErrorMessage);
  });
}
