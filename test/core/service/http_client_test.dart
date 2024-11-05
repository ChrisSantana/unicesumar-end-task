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
          {'id': 1, 'title': 'Tarefa A'}
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
}
