import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_end/core/entity/request_state_entity.dart';
import 'package:task_end/features/task/data/task_service.dart';
import 'package:task_end/features/task/domain/task_entity.dart';

final class TaskBloc extends Cubit<IRequestState> {
  final ITaskService taskService;
  TaskBloc(this.taskService) : super(const RequestInitiationState());

  Future<void> onFetchTasks() async {
    try {
      emit(const RequestProcessingState());

      await Future.delayed(Duration(seconds: Random().nextInt(4)));
      final List<TaskEntity> tasks = await taskService.fetchTasks();

      emit(RequestCompletedState(value: tasks));
    } catch (error) {
      emit(RequestErrorState(error: error));
    }
  }

  Future<void> onDeleteTask(String idTask) async {
    try {
      emit(const RequestProcessingState());

      final bool success = await taskService.deleteTask(idTask);

      if (success) onFetchTasks();
      if (!success) emit(RequestErrorState(error: Exception()));
    } catch (error) {
      emit(RequestErrorState(error: error));
    }
  }
}
