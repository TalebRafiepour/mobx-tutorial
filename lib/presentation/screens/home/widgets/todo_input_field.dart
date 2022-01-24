import 'package:flutter/material.dart';
import 'package:todo_mobx/generated/l10n.dart';
import 'package:todo_mobx/presentation/logic/home/src/home_store.dart';
import 'package:todo_mobx/presentation/logic/home/src/todo_model.dart';

class TodoInputField extends StatelessWidget {
  final HomeStore homeStore;

  const TodoInputField({Key? key, required this.homeStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(

      onSubmitted: (value) {
        if (value.isNotEmpty) {
          homeStore.addTodo(TodoModel(value));
        }
      },
      decoration: InputDecoration(
        hintText: S.of(context).enterYourTodoCaption,
      ),
    );
  }
}
