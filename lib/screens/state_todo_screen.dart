import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod_proj/providers/provider.dart';
import 'package:flutter_riverpod_proj/widgets/dismissible_todo.dart';

class StateTodoScreen extends ConsumerWidget {
  final bool isCompleted;
  const StateTodoScreen({super.key, this.isCompleted = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos =
        ref.watch(isCompleted ? completedTodoProvider : activeTodoProvider);
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return DismissibleTodo(todo: todo);
        });
  }
}
