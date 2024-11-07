import 'package:task_end/core/bloc/factory_bloc.dart';
import 'package:task_end/core/service/http_client.dart';
import 'package:task_end/features/task/data/task_service.dart';
import 'package:task_end/features/task/presentation/bloc/task_bloc.dart';

final class TaskFactoryBloc implements IFactoryBloc<TaskBloc> {
  const TaskFactoryBloc();

  @override
  TaskBloc create(BuildContext context) {
    return TaskBloc(
      TaskService(
        HttpClientFactory().createHttpClient(),
      ),
    );
  }

  @override
  void dispose(BuildContext context, TaskBloc bloc) {
    bloc.close();
  }
}
