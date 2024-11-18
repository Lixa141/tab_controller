enum Status {
  inProgress('in progress'),
  failed('failed'),
  done('done'),
  deleted('deleted'),
  unidentified('');

  const Status(this.value);

  final String value;

  factory Status.from(String? name) {
    return Status.values.firstWhere(
          (e) => e.value == name,
      orElse: () => Status.unidentified,
    );
  }
}

final class Task{
  final String taskId;
  final DateTime createdAt;
  final Status status;

  Task({
    required this.taskId,
    required this.createdAt,
    required this.status,
  });

}