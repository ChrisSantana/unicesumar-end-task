import 'package:task_end/core/error/http_exception.dart';
import 'package:task_end/core/library/util_text.dart';

extension ExceptionDescription on Exception? {
  String description() {
    if (this is HttpNotFoundException) return UtilText.labelHttpNotFoundException;
    if (this is HttpExpiredTokenException) return UtilText.labelHttpExpiredToken;
    if (this is HttpInvalidOperationException) return UtilText.labelHttpInvalidOperation;
    if (this is HttpNotPermissionException) return UtilText.labelHttpNotPermissionException;
    if (this is HttpTimeoutException) return UtilText.labelHttpTimeoutException;
    if (this is HttpInternetConnectionFailure) return UtilText.labelHttpInternetConnectionFailure;
    if (this is HttpError) return UtilText.labelHttpDefault;
    return UtilText.labelHttpGenericErrorMessage;
  }
}
