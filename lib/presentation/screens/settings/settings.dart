import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/generated/l10n.dart';
import 'package:todo_mobx/locator.dart';
import 'package:todo_mobx/presentation/logic/settings/index.dart';
import 'package:todo_mobx/presentation/screens/settings/widgets/select_language_popup.dart';
import 'package:todo_mobx/presentation/screens/settings/widgets/select_theme_popup.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsStore _settingsStore = locator.get<SettingsStore>();

  @override
  void initState() {
    Future.microtask(() => _settingsStore.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          if (index == 0) {
            return Column(
              children: [
                ListTile(
                  title: const Text('Language'),
                  trailing: Observer(builder: (context) {
                    return Text(_settingsStore.selectedLocale.languageCode
                        .toLowerCase());
                  }),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => SelectLanguagePopup(
                        settingsStore: _settingsStore,
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
              ],
            );
          } else if (index == 1) {
            return ListTile(
              title: const Text('Theme'),
              trailing: Observer(builder: (context) {
                return Text(_settingsStore.themeMode.toString());
              }),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => SelectThemePopup(
                    settingsStore: _settingsStore,
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
        itemCount: 2,
      ),
    );
  }
}
