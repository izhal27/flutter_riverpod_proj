import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod_proj/models/todo.dart';
import 'package:flutter_riverpod_proj/providers/provider.dart';
import 'package:flutter_riverpod_proj/widgets/text_todo.dart';

class DismissibleTodo extends ConsumerWidget {
  final Todo todo;

  const DismissibleTodo({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (DismissDirection.endToStart == direction) {
          final bool? confirmDelete = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Konfirmasi'),
                content:
                    const Text('Apakah Anda yakin ingin menghapus todo ini?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Hapus'),
                  ),
                ],
              );
            },
          );
          return confirmDelete ?? false;
        }
        return false;
      },
      onDismissed: (direction) {
        if (DismissDirection.endToStart == direction) {
          ref.read(todoProvider.notifier).removeTodo(todo.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text('todo deleted'),
            ),
          );
        }
      },
      child: ListTile(
        title: TextTodo(todo: todo),
        trailing: Checkbox(
          value: todo.completed,
          onChanged: (check) =>
              ref.read(todoProvider.notifier).markStatus(todo.id, check!),
        ),
      ),
    );
  }
}
