import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/presentation/logic/home/src/home_store.dart';

class TodoList extends StatelessWidget {
  final HomeStore homeStore;

  const TodoList({Key? key, required this.homeStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Flexible(
        child: ListView.builder(
          itemCount: homeStore.todos.length,
          itemBuilder: (_, index) {
            final model = homeStore.todos[index];
            return Observer(
              builder: (_) => CheckboxListTile(
                  title: Text(model.description),
                  value: model.isDone,
                  onChanged: (value) => model.isDone = value ?? model.isDone),
            );
          },
        ),
      );
    });
  }
}
