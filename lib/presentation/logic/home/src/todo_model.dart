import 'package:mobx/mobx.dart';

part 'todo_model.g.dart';

class TodoModel = _TodoModel with _$TodoModel;

abstract class _TodoModel with Store {

  final String description;

  _TodoModel(this.description);

  @observable
  bool isDone = false;
}