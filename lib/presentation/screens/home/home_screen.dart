import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/models/login/src/user_model.dart';
import 'package:todo_mobx/data/providers/storage/secure/secure_storage.dart';
import 'package:todo_mobx/presentation/logic/home/src/home_store.dart';
import 'package:todo_mobx/presentation/screens/profile/profile_screen.dart';
import 'package:todo_mobx/presentation/screens/settings/settings.dart';

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
        // showModalBottomSheet(context: context, builder: (ctx) {
        //   return Text(message);
        // });
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
          actions: [
            IconButton(
              icon: Icon(Icons.supervised_user_circle_rounded,color: Theme.of(context).iconTheme.color,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.settings,color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
          title: FutureBuilder<UserModel?>(
              future: SecureStorage().getUserData(),
              builder: (context, AsyncSnapshot<UserModel?> snapShot) {
                if (snapShot.connectionState == ConnectionState.done) {
                  return Text('ToDo ${snapShot.data?.firstName ?? '---'}');
                } else {
                  return const Text('ToDo');
                }
              }),
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
