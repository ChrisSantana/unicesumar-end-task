import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_end/core/entity/request_state_entity.dart';
import 'package:task_end/core/enum/app_state_enum.dart';
import 'package:task_end/core/widget/progress_indicator_widget.dart';

class RequestWidget<B extends StateStreamable<IRequestState<T>>, T> extends StatelessWidget {
  final Widget? processingWidget;
  final Widget? errorWidget;
  final Widget? noneWidget;
  final Widget? dataEmptyWidget;
  final Widget Function(BuildContext context, T? data, IRequestState state) builder;
  final void Function(BuildContext context, IRequestState state)? listener;

  const RequestWidget({
    super.key,
    required this.builder,
    this.processingWidget,
    this.errorWidget,
    this.noneWidget,
    this.dataEmptyWidget,
    this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, IRequestState<T>>(
      listener: _onListener,
      builder: (context, requestState) {
        switch (requestState.status) {
          case AppStateEnum.none:
            return _FactoryWidget(child: noneWidget);
          case AppStateEnum.processing:
            return _FactoryWidget(child: processingWidget);
          case AppStateEnum.completed:
            return builder(context, requestState.dataOrNull, requestState);
          case AppStateEnum.error:
            return _FactoryWidget(
              child: errorWidget ?? builder(context, requestState.dataOrNull, requestState),
            );
        }
      },
    );
  }

  void _onListener(BuildContext context, IRequestState state) {
    if (listener != null) listener!(context, state);
  }
}

class _FactoryWidget extends StatelessWidget {
  final Widget? child;
  const _FactoryWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (child != null) return child!;
    return const Center(
      child: ProgressIndicatorWidget(),
    );
  }
}
