import 'package:flutter/material.dart';

class TodoFilterBox extends StatelessWidget {
  const TodoFilterBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          RadioListTile(
              value: 'value', groupValue: 'groupValue', onChanged: (value) {}),
        ],
      ),
    );
  }
}
