import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_end/core/entity/http_response_entity.dart';
import 'package:task_end/core/library/constants.dart';
import 'package:task_end/core/service/http_client.dart';

final class DioMock extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions();
}

void main() {
  late final DioMock tDioMock;
  late final String tUri;
  late final IHttpClient tClientHttp;

  setUpAll(() {
    tUri = 'https://api.unicesumar.com';
    tDioMock = DioMock();
    tClientHttp = HttpClientDio(tDioMock);
  });

  test('should valid method POST', () async {
    // Arrange
    final postData = {'title': 'Nova Tarefa'};
    when(() => tDioMock.post(tUri, data: postData)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: tUri),
        statusCode: HttpConstant.kSuccess,
        data: {'id': '1', 'title': 'Nova Tarefa'},
      ),
    );

    // Act
    final HttpResponseEntity response = await tClientHttp.post(tUri, data: postData);

    // Assert
    expect(response.statusCode, HttpConstant.kSuccess);
    expect(response.data, isA<Map>());
    expect(response.data['title'], 'Nova Tarefa');
  });
}
