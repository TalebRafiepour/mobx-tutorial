// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$alertMessageAtom = Atom(name: '_HomeStore.alertMessage');

  @override
  String? get alertMessage {
    _$alertMessageAtom.reportRead();
    return super.alertMessage;
  }

  @override
  set alertMessage(String? value) {
    _$alertMessageAtom.reportWrite(value, super.alertMessage, () {
      super.alertMessage = value;
    });
  }

  final _$todosAtom = Atom(name: '_HomeStore.todos');

  @override
  ObservableList<TodoModel> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<TodoModel> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void addTodo(TodoModel todoModel) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.addTodo');
    try {
      return super.addTodo(todoModel);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
alertMessage: ${alertMessage},
todos: ${todos}
    ''';
  }
}
