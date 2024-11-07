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

  test('should valid method GET', () async {
    // Arrange
    when(() => tDioMock.get(tUri)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: tUri),
        statusCode: HttpConstant.kSuccess,
        data: [
          {'id': '1', 'title': 'Tarefa A'}
        ],
      ),
    );

    // Act
    final HttpResponseEntity response = await tClientHttp.get(tUri);

    // Assert
    expect(response.statusCode, HttpConstant.kSuccess);
    expect(response.data, isA<List>());
    expect(response.data.first['title'], 'Tarefa A');
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

  test('should valid method PUT', () async {
    // Arrange
    final putData = {'id': '1', 'title': 'Tarefa Atualizada'};
    when(() => tDioMock.put(tUri, data: putData)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: tUri),
        statusCode: HttpConstant.kSuccess,
        data: {'id': '1', 'title': 'Tarefa Atualizada'},
      ),
    );

    // Act
    final HttpResponseEntity response = await tClientHttp.put(tUri, data: putData);

    // Assert
    expect(response.statusCode, HttpConstant.kSuccess);
    expect(response.data, isA<Map>());
    expect(response.data['title'], 'Tarefa Atualizada');
  });

  test('should valid method PATCH', () async {
    // Arrange
    final patchData = {'title': 'Tarefa Modificada'};
    when(() => tDioMock.patch(tUri, data: patchData)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: tUri),
        statusCode: HttpConstant.kSuccess,
        data: {'id': '1', 'title': 'Tarefa Modificada'},
      ),
    );

    // Act
    final HttpResponseEntity response = await tClientHttp.patch(tUri, data: patchData);

    // Assert
    expect(response.statusCode, HttpConstant.kSuccess);
    expect(response.data, isA<Map>());
    expect(response.data['title'], 'Tarefa Modificada');
  });

  test('should valid method DELETE', () async {
    // Arrange
    when(() => tDioMock.delete(tUri)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: tUri),
        statusCode: HttpConstant.kSuccess,
        data: {},
      ),
    );

    // Act
    final HttpResponseEntity response = await tClientHttp.delete(tUri);

    // Assert
    expect(response.statusCode, HttpConstant.kSuccess);
    expect(response.data, isEmpty);
  });
}
