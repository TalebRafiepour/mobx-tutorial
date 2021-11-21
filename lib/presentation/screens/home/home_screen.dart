import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/presentation/logic/home/src/home_store.dart';

import 'widgets/todo_input_field.dart';
import 'widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeStore = HomeStore();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();

  late ReactionDisposer _disposer;

  @override
  void initState() {
    _disposer = reaction((_) => homeStore.alertMessage, (String? message) {
      if (message != null) {
        _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo'),
        ),
        body: Column(
          children: [
            TodoInputField(homeStore: homeStore),
            //const TodoFilterBox(),
            const Divider(
              height: 2,
            ),
            TodoList(homeStore: homeStore),
          ],
        ),
      ),
    );
  }
}
