import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:task_end/core/library/clock_helper.dart';
export 'package:task_end/core/library/injection_container.dart';
export 'package:task_end/core/service/app_service.dart';

abstract interface class IFactoryBloc<T> {
  T create(BuildContext context);
  void dispose(BuildContext context, T bloc);
}
