import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:task_end/core/entity/http_response_entity.dart';
import 'package:task_end/core/library/constants.dart';

abstract interface class IHttpClient {
  Future<HttpResponseEntity> get(String uri);
  Future<HttpResponseEntity> post(String uri, {dynamic data});
  Future<HttpResponseEntity> put(String uri, {dynamic data});
  Future<HttpResponseEntity> patch(String uri, {dynamic data});
  Future<HttpResponseEntity> delete(String uri, {dynamic data});
}

/// #region Http Client
final class HttpClient implements IHttpClient {
  final http.Client client;
  const HttpClient(this.client);

  @override
  Future<HttpResponseEntity> get(String uri) async {
    try {
      final http.Response response = await client.get(Uri.parse(uri));
      return _createHttpResponseFromResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> patch(String uri, {dynamic data}) async {
    try {
      final http.Response response = await client.patch(Uri.parse(uri), body: data);
      return _createHttpResponseFromResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> post(String uri, {dynamic data}) async {
    try {
      final http.Response response = await client.post(Uri.parse(uri), body: data);
      return _createHttpResponseFromResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> put(String uri, {dynamic data}) async {
    try {
      final http.Response response = await client.put(Uri.parse(uri), body: data);
      return _createHttpResponseFromResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> delete(String uri, {dynamic data}) async {
    try {
      final http.Response response = await client.delete(Uri.parse(uri), body: data);
      return _createHttpResponseFromResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  HttpResponseEntity _createHttpResponseFromResponse(http.Response response) {
    return HttpResponseEntity(
      data: jsonDecode(response.body),
      statusCode: response.statusCode,
    );
  }
}

/// #region Dio
final class HttpClientDio implements IHttpClient {
  final Dio dio;
  const HttpClientDio(this.dio);

  @override
  Future<HttpResponseEntity> get(String uri) async {
    try {
      final Response response = await dio.get(uri);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> post(String uri, {dynamic data}) async {
    try {
      final Response response = await dio.post(uri, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> put(String uri, {dynamic data}) async {
    try {
      final Response response = await dio.put(uri, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> patch(String uri, {dynamic data}) async {
    try {
      final Response response = await dio.patch(uri, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity> delete(String uri, {dynamic data}) async {
    try {
      final Response response = await dio.delete(uri, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  HttpResponseEntity _createHttpResponseFromResponse(Response response) {
    return HttpResponseEntity(
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}

/// #region Factory for Clients Http
final class HttpClientFactory {
  IHttpClient createFromDio() {
    const int kSecondsBase = 100;
    const Duration durationTimeout = Duration(seconds: ComumConstant.kSecondsTimeoutDefault * kSecondsBase);
    return HttpClientDio(
      Dio(
        BaseOptions(
          connectTimeout: durationTimeout,
          sendTimeout: durationTimeout,
          receiveTimeout: durationTimeout,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          validateStatus: (value) => value != null,
        ),
      ),
    );
  }

  IHttpClient createHttpClient() {
    return HttpClient(http.Client());
  }
}
