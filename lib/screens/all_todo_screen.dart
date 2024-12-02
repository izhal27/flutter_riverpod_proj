import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod_proj/providers/provider.dart';
import 'package:flutter_riverpod_proj/widgets/dismissible_todo.dart';

class AllTodoScreen extends ConsumerWidget {
  const AllTodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return DismissibleTodo(todo: todo);
      },
    );
  }
}
