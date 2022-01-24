import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/core/consts/m_consts.dart';
import 'package:todo_mobx/presentation/logic/settings/index.dart';

class SelectLanguagePopup extends StatefulWidget {
  final SettingsStore settingsStore;

  const SelectLanguagePopup({Key? key, required this.settingsStore})
      : super(key: key);

  @override
  _SelectLanguagePopupState createState() => _SelectLanguagePopupState();
}

class _SelectLanguagePopupState extends State<SelectLanguagePopup> {
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
              'Selected Language Code',
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
                return RadioListTile<Locale>(
                    title: Text(
                        MConstants.locales[index].languageCode.toLowerCase()),
                    value: MConstants.locales[index],
                    groupValue: widget.settingsStore.selectedLocale,
                    onChanged: (Locale? locale) {
                      widget.settingsStore.selectedLocale =
                          locale ?? widget.settingsStore.selectedLocale;
                    });
              });
            },
            itemCount: MConstants.locales.length,
          )),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
                onPressed: () {
                  widget.settingsStore.setLocale();
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
