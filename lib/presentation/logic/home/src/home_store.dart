import 'package:mobx/mobx.dart';

import 'todo_model.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {

  @observable
  String? alertMessage;

  @observable
  ObservableList<TodoModel> todos = ObservableList();

  @action
  void addTodo(TodoModel todoModel) {
    alertMessage = 'New Todo (${todoModel.description}) added.';
    todos.add(todoModel);
  }
}
