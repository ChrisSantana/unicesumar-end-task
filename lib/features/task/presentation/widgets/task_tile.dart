import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_end/core/entity/request_state_entity.dart';
import 'package:task_end/core/library/theme_helper.dart';
import 'package:task_end/core/widget/text_extension_widget.dart';
import 'package:task_end/features/task/domain/task_entity.dart';
import 'package:task_end/features/task/presentation/bloc/task_bloc.dart';

class TaskTile extends StatelessWidget {
  final TaskEntity task;
  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Código: ${task.id}'),
                  Text(task.title).font15W600(),
                ],
              ),
            ),
            BlocBuilder<TaskBloc, IRequestState>(
              builder: (context, state) {
                final bool isProcessing = state is RequestProcessingState;
                return IconButton(
                  onPressed: !isProcessing
                      ? () {
                          context.read<TaskBloc>().onDeleteTask(task.id);
                        }
                      : null,
                  icon: Icon(
                    Icons.delete,
                    color: ThemeHelper.redColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
