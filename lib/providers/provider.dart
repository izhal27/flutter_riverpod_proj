import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod_proj/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(),
);

final activeTodoProvider = StateProvider<List<Todo>>(
  (ref) {
    final todos = ref.watch(todoProvider);
    return todos.where((todo) => !todo.completed).toList();
  },
);

final completedTodoProvider = StateProvider<List<Todo>>(
  (ref) {
    final todos = ref.watch(todoProvider);
    return todos.where((todo) => todo.completed).toList();
  },
);

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier()
      : super(
          [
            Todo(text: 'Mauris sollicitudin fermentum libero.'),
            Todo(text: 'Nunc sed turpis.'),
            Todo(text: 'Praesent adipiscing.'),
            Todo(text: 'Donec vitae orci sed dolor rutrum auctor.'),
            Todo(text: 'Aenean leo ligula, porttitor eu.'),
            Todo(text: 'Pellentesque egestas.'),
            Todo(text: 'Mauris sollicitudin fermentum libero.'),
            Todo(text: 'Sed consequat, leo eget bibendum sodales.'),
          ],
        );

  void addTodo(Todo todo) {
    state = [todo, ...state];
  }

  void updateTodo(Todo updatedTodo) {
    state = state.map((todo) {
      if (todo.id == updatedTodo.id) {
        return updatedTodo;
      }
      return todo;
    }).toList();
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void markStatus(String id, bool status) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          text: todo.text,
          completed: status,
        );
      }
      return todo;
    }).toList();
  }
}
