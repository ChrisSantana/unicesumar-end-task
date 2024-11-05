import 'package:flutter/material.dart';
import 'package:task_end/core/widget/text_extension_widget.dart';
import 'package:task_end/features/task/domain/task_entity.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Código: ${task.id}'),
            Text(task.title).font15W600(),
          ],
        ),
      ),
    );
  }
}
