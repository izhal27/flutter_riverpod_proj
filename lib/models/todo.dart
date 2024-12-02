import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Todo {
  final String id;
  final String text;
  final bool completed;

  Todo({
    String? id,
    required this.text,
    this.completed = false,
  }) : id = id ?? uuid.v1();

  Todo copyWith({
    String? id,
    String? text,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      completed: completed ?? this.completed,
    );
  }
}
