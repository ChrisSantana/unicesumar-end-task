import 'dart:convert';

import 'package:task_end/core/entity/http_response_entity.dart';
import 'package:task_end/core/library/constants.dart';
import 'package:task_end/core/service/http_client.dart';
import 'package:task_end/features/task/domain/task_entity.dart';

const String kTaskUrlBaseForAndroid = 'http://10.0.2.2:3000';
const String kTaskUrlBaseForWeb = 'http://localhost:3000';

abstract interface class ITaskService {
  Future<List<TaskEntity>> fetchTasks();
  Future<bool> insertTask(TaskEntity task);
  Future<bool> updateTask(TaskEntity task);
  Future<bool> deleteTask(String id);
}

final class TaskService implements ITaskService {
  final IHttpClient httpClient;
  const TaskService(this.httpClient);

  @override
  Future<List<TaskEntity>> fetchTasks() async {
    try {
      final HttpResponseEntity response = await httpClient.get('$kTaskUrlBaseForAndroid/tasks');
      return response.toSuccess() ? (response.data as List).map<TaskEntity>((map) => TaskEntity.fromMap(map)).toList() : [];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> insertTask(TaskEntity task) async {
    try {
      final String json = jsonEncode(task.toMap());
      final HttpResponseEntity response = await httpClient.post('$kTaskUrlBaseForAndroid/tasks', data: json);
      if (!response.toSuccess()) throw Exception('Não foi possível inserir a task');
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateTask(TaskEntity task) async {
    try {
      final String json = jsonEncode(task.toMap());
      final HttpResponseEntity response = await httpClient.put('$kTaskUrlBaseForAndroid/tasks/${task.id}', data: json);
      if (!response.toSuccess()) throw Exception('Não foi possível atualizar a task');
      return response.statusCode == HttpConstant.kSuccess;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    try {
      final HttpResponseEntity response = await httpClient.delete('$kTaskUrlBaseForAndroid/tasks/$id');
      if (!response.toSuccess()) throw Exception('Não foi possível remover a task');
      return response.statusCode == HttpConstant.kSuccess;
    } catch (_) {
      rethrow;
    }
  }
}

extension _HttpExtension on HttpResponseEntity {
  bool toSuccess() {
    return ((statusCode ?? 0) >= HttpConstant.kSuccess) && ((statusCode ?? 0) <= HttpConstant.kSuccessLimit);
  }
}
