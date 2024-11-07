import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_end/core/entity/http_response_entity.dart';
import 'package:task_end/core/library/constants.dart';
import 'package:task_end/core/service/http_client.dart';
import 'package:task_end/features/task/data/task_service.dart';
import 'package:task_end/features/task/domain/task_entity.dart';

final class HttpClientMock extends Mock implements IHttpClient {}

void main() {
  late final IHttpClient tHttpClientMock;
  late final ITaskService tTaskService;
  late final String tUrlBase;

  setUpAll(() {
    tHttpClientMock = HttpClientMock();
    tTaskService = TaskService(tHttpClientMock);
    tUrlBase = kTaskUrlBaseForAndroid;
  });

  test('should fetch tasks from API', () async {
    // Arrange
    final mockResponse = HttpResponseEntity(
      data: [
        {'id': '1', 'title': 'Task A'},
        {'id': '2', 'title': 'Task B'},
      ],
      statusCode: HttpConstant.kSuccess,
    );
    when(() => tHttpClientMock.get('$tUrlBase/tasks')).thenAnswer((_) async => mockResponse);

    // Act
    final List<TaskEntity> tasks = await tTaskService.fetchTasks();

    // Assert
    expect(tasks, isNotEmpty);
    expect(tasks.first.id, '1');
    expect(tasks.first.title, 'Task A');
  });

  test('should insert task into API', () async {
    // Arrange
    final TaskEntity task = TaskEntity(id: '100', title: 'New task');
    final String json = jsonEncode(task.toMap());
    final mockResponse = HttpResponseEntity(
      data: '1',
      statusCode: HttpConstant.kSuccess,
    );
    when(() => tHttpClientMock.post('$tUrlBase/tasks', data: json)).thenAnswer((_) async => mockResponse);

    // Act
    final bool success = await tTaskService.insertTask(task);

    // Assert
    expect(success, isTrue);
  });

  test('should update task on API', () async {
    // Arrange
    final task = TaskEntity(id: '1', title: 'Updated Task');
    final String json = jsonEncode(task.toMap());
    final mockResponse = HttpResponseEntity(
      data: null,
      statusCode: HttpConstant.kSuccess,
    );
    when(() => tHttpClientMock.put('$tUrlBase/tasks/${task.id}', data: json)).thenAnswer((_) async => mockResponse);

    // Act
    final bool success = await tTaskService.updateTask(task);

    // Assert
    expect(success, isTrue);
  });

  test('should delete task from API', () async {
    // Arrange
    const String taskId = '1';
    final mockResponse = HttpResponseEntity(
      data: null,
      statusCode: HttpConstant.kSuccess,
    );
    when(() => tHttpClientMock.delete('$tUrlBase/tasks/$taskId')).thenAnswer((_) async => mockResponse);

    // Act
    final bool success = await tTaskService.deleteTask(taskId);

    // Assert
    expect(success, isTrue);
  });
}
