import 'package:flutter_test/flutter_test.dart';
import 'package:task_end/core/entity/request_state_entity.dart';
import 'package:task_end/core/enum/app_state_enum.dart';
import 'package:task_end/core/error/http_exception.dart';

void main() {
  test('should validate request initial entity', () async {
    /// Act
    final RequestInitiationState<String> requestInitial = RequestInitiationState<String>(value: 'initial');

    /// Assert
    expect(requestInitial.status, AppStateEnum.none);
    expect(requestInitial.dataOrNull, isNotNull);
    expect(requestInitial.data, 'initial');
    expect(requestInitial.value, 'initial');
  });

  test('should validate request completed entity', () async {
    /// Act
    final RequestCompletedState<String> requestCompleted = RequestCompletedState<String>(value: 'completed');

    /// Assert
    expect(requestCompleted.status, AppStateEnum.completed);
    expect(requestCompleted.dataOrNull, isNotNull);
    expect(requestCompleted.data, 'completed');
    expect(requestCompleted.value, 'completed');
  });

  test('should validate request processing entity', () async {
    /// Act
    final RequestProcessingState<String> requestProcessing = RequestProcessingState<String>(value: 'processing');

    /// Assert
    expect(requestProcessing.status, AppStateEnum.processing);
    expect(requestProcessing.dataOrNull, isNotNull);
    expect(requestProcessing.data, 'processing');
    expect(requestProcessing.value, 'processing');
  });

  test('should validate request error entity', () async {
    /// Act
    final RequestErrorState<Exception> requestError = RequestErrorState<Exception>(error: HttpInternetConnectionFailure());

    /// Assert
    expect(requestError.status, AppStateEnum.error);
    expect(requestError.dataOrNull, isNull);
    expect(requestError.error, isA<HttpInternetConnectionFailure>());
    expect(requestError.value, isNull);
  });
}
