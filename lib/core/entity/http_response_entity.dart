final class HttpResponseEntity<T> {
  const HttpResponseEntity({
    this.data,
    this.statusCode,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  final T? data;

  /// Http status code.
  final int? statusCode;
}

final class HttpResponseApiPaginatedEntity {
  final int currentPage;
  final int totalItems;
  final int totalPages;
  final List data;

  const HttpResponseApiPaginatedEntity({
    required this.currentPage,
    required this.totalItems,
    required this.totalPages,
    required this.data,
  });

  factory HttpResponseApiPaginatedEntity.fromMap(Map<String, dynamic> map) {
    return HttpResponseApiPaginatedEntity(
      currentPage: map[kKeyCurrentPage],
      totalItems: map[kKeyTotalItems],
      totalPages: map[kKeyTotalPages],
      data: map[kKeyData],
    );
  }

  static const String kKeyCurrentPage = 'currentPage';
  static const String kKeyTotalItems = 'totalItems';
  static const String kKeyTotalPages = 'totalPages';
  static const String kKeyData = 'data';
}
