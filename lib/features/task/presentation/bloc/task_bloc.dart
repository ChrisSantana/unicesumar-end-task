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

      await taskService.insertTask('Fazer as correções');
      final List<TaskEntity> tasks = await taskService.fetchTasks();

      emit(RequestCompletedState(value: tasks));
    } catch (error) {
      emit(RequestErrorState(error: error));
    }
  }
}
