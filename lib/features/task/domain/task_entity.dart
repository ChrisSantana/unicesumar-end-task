final class TaskEntity {
  final String id;
  final String title;

  const TaskEntity({
    required this.id,
    required this.title,
  });

  factory TaskEntity.fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map[kKeyId],
      title: map[kKeyTitle],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kKeyId: id,
      kKeyTitle: title,
    };
  }

  static const String kKeyId = 'id';
  static const String kKeyTitle = 'title';
}
