import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:task_end/core/library/constants.dart';
import 'package:task_end/core/service/http_client.dart';

final class HttpClientMock extends Mock implements http.Client {}

void main() {
  late HttpClientMock tHttpClientMock;
  late IHttpClient tClientHttp;
  late String tUri;

  setUpAll(() {
    tUri = 'https://api.unicesumar.com';
    tHttpClientMock = HttpClientMock();
    tClientHttp = HttpClient(tHttpClientMock);
  });

  test('should valid method GET', () async {
    // Arrange
    when(() => tHttpClientMock.get(Uri.parse(tUri))).thenAnswer(
      (_) async => http.Response(
        jsonEncode([
          {'id': '1', 'title': 'Tarefa A'}
        ]),
        HttpConstant.kSuccess,
      ),
    );

    // Act
    final result = await tClientHttp.get(tUri);

    // Assert
    expect(result.statusCode, HttpConstant.kSuccess);
    expect(result.data, isA<List>());
    expect(result.data.first['title'], 'Tarefa A');
  });

  test('should valid method POST', () async {
    // Arrange
    final postData = {'title': 'Nova Tarefa'};
    when(() => tHttpClientMock.post(Uri.parse(tUri), body: postData)).thenAnswer(
      (_) async => http.Response(
        jsonEncode({'id': '1', 'title': 'Nova Tarefa'}),
        HttpConstant.kSuccess,
      ),
    );

    // Act
    final result = await tClientHttp.post(tUri, data: postData);

    // Assert
    expect(result.statusCode, HttpConstant.kSuccess);
    expect(result.data, isA<Map>());
    expect(result.data['title'], 'Nova Tarefa');
  });

  test('should valid method PUT', () async {
    // Arrange
    final putData = {'id': '1', 'title': 'Tarefa Atualizada'};
    when(() => tHttpClientMock.put(Uri.parse(tUri), body: putData)).thenAnswer(
      (_) async => http.Response(
        jsonEncode({'id': '1', 'title': 'Tarefa Atualizada'}),
        HttpConstant.kSuccess,
      ),
    );

    // Act
    final result = await tClientHttp.put(tUri, data: putData);

    // Assert
    expect(result.statusCode, HttpConstant.kSuccess);
    expect(result.data, isA<Map>());
    expect(result.data['title'], 'Tarefa Atualizada');
  });

  test('should valid method PATCH', () async {
    // Arrange
    final patchData = {'title': 'Tarefa Modificada'};
    when(() => tHttpClientMock.patch(Uri.parse(tUri), body: patchData)).thenAnswer(
      (_) async => http.Response(
        jsonEncode({'id': '1', 'title': 'Tarefa Modificada'}),
        HttpConstant.kSuccess,
      ),
    );

    // Act
    final result = await tClientHttp.patch(tUri, data: patchData);

    // Assert
    expect(result.statusCode, HttpConstant.kSuccess);
    expect(result.data, isA<Map>());
    expect(result.data['title'], 'Tarefa Modificada');
  });

  test('should valid method DELETE', () async {
    // Arrange
    when(() => tHttpClientMock.delete(Uri.parse(tUri))).thenAnswer(
      (_) async => http.Response(
        jsonEncode({}),
        HttpConstant.kSuccess,
      ),
    );

    // Act
    final result = await tClientHttp.delete(tUri);

    // Assert
    expect(result.statusCode, HttpConstant.kSuccess);
    expect(result.data, isEmpty);
  });
}
