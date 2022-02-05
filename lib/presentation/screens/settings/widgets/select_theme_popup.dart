import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/core/consts/m_consts.dart';
import 'package:todo_mobx/presentation/logic/settings/index.dart';

class SelectThemePopup extends StatefulWidget {
  final SettingsStore settingsStore;

  const SelectThemePopup({Key? key, required this.settingsStore})
      : super(key: key);

  @override
  _SelectThemePopupState createState() => _SelectThemePopupState();
}

class _SelectThemePopupState extends State<SelectThemePopup> {
  late final ReactionDisposer _disposer;

  @override
  void initState() {
    _disposer =
        reaction((_) => widget.settingsStore.changesSaved, _stateReaction);
    super.initState();
  }

  @override
  void dispose() {
    _disposer.call();
    super.dispose();
  }

  void _stateReaction(bool changesSaved) {
    if (changesSaved) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          const Center(
            child: Text(
              'Selected Theme Mode',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (_, index) {
              return Observer(builder: (context) {
                return RadioListTile<ThemeMode>(
                    title: Text(MConstants.themeModes[index].toString()),
                    value: MConstants.themeModes[index],
                    groupValue: widget.settingsStore.themeMode,
                    onChanged: (ThemeMode? themeMode) {
                      widget.settingsStore.setTheme(
                          themeMode ?? widget.settingsStore.themeMode);
                      Navigator.of(context).pop();
                    });
              });
            },
            itemCount: MConstants.themeModes.length,
          )),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Observer(
                  builder: (_) {
                    if (widget.settingsStore.isLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Icon(Icons.save);
                    }
                  },
                ),
                label: const Text(
                  'Save',
                  style: TextStyle(fontSize: 14),
                )),
          )
        ],
      ),
    );
  }
}
