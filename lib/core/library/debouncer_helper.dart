import 'dart:async';

import 'package:flutter/foundation.dart';

abstract interface class IDebouncerHelper {
  void run(VoidCallback action, {int milliseconds = 500});
}

final class DebouncerHelper implements IDebouncerHelper {
  static Timer? _timer;

  @override
  void run(VoidCallback action, {int milliseconds = 500}) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      action.call();
      _timer?.cancel();
    });
  }
}
