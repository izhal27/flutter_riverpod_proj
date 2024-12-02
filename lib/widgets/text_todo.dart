import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod_proj/models/todo.dart';
import 'package:flutter_riverpod_proj/providers/provider.dart';

class TextTodo extends ConsumerStatefulWidget {
  final Todo todo;
  const TextTodo({super.key, required this.todo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListtileTodoState();
}

class _ListtileTodoState extends ConsumerState<TextTodo> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? TextField(
            controller: _controller,
            autofocus: true,
            onSubmitted: (value) {
              setState(() {
                _isEditing = false;
              });
              if (value.isNotEmpty) {
                ref
                    .read(todoProvider.notifier)
                    .updateTodo(widget.todo.copyWith(text: value));
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Edit Todo',
            ),
          )
        : GestureDetector(
            child: Text(widget.todo.text),
            onTap: () {
              setState(() {
                _isEditing = true;
              });
            },
          );
  }
}
