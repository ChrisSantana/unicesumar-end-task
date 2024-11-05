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
    tUrlBase = kTaskUrlBase;
  });

  test('should insert task into API', () async {
    // Arrange
    const taskTitle = 'New Task';
    final mockResponse = HttpResponseEntity(
      data: 1,
      statusCode: HttpConstant.kSuccess,
    );
    when(() => tHttpClientMock.post('$tUrlBase/insert-task', data: taskTitle)).thenAnswer((_) async => mockResponse);

    // Act
    final TaskEntity task = await tTaskService.insertTask(taskTitle);

    // Assert
    expect(task.id, 1);
    expect(task.title, taskTitle);
  });
}
