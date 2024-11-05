import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_end/core/entity/request_state_entity.dart';
import 'package:task_end/core/library/theme_helper.dart';
import 'package:task_end/core/widget/divider_widget.dart';
import 'package:task_end/core/widget/progress_indicator_widget.dart';
import 'package:task_end/features/task/domain/task_entity.dart';
import 'package:task_end/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_end/features/task/presentation/bloc/task_factory_bloc.dart';
import 'package:task_end/features/task/presentation/widgets/task_tile.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: TaskFactoryBloc().create,
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _TasksWidget(),
          ),
          _ButtonWidget(),
        ],
      ),
    );
  }
}

class _TasksWidget extends StatelessWidget {
  const _TasksWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, IRequestState>(
      builder: (context, state) {
        final List<TaskEntity> tasks = (state.dataOrNull ?? []);
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          itemCount: tasks.length,
          separatorBuilder: (context, index) {
            return DividerWidget(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: ThemeHelper.grayLightColor,
              height: 0.5,
            );
          },
          itemBuilder: (context, index) {
            return TaskTile(task: tasks.elementAt(index));
          },
        );
      },
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, IRequestState>(
      builder: (context, state) {
        final bool isProcessing = state is RequestProcessingState;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            height: 48,
            child: ElevatedButton(
              onPressed: isProcessing ? null : context.read<TaskBloc>().onFetchTasks,
              child: isProcessing ? ProgressIndicatorWidget() : Text('Obter as Tasks'),
            ),
          ),
        );
      },
    );
  }
}
