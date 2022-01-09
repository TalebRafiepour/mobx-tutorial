import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/presentation/logic/profile/index.dart';

class ProfileImage extends StatelessWidget {
  final ProfileStore profileStore;

  const ProfileImage({Key? key, required this.profileStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return profileStore.profileImageState.when(loading: (double percent) {
        return SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            value: percent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
            backgroundColor: Colors.purple,
          ),
        );
      }, error: (message) {
        return Container(
          height: 80,
          width: 80,
          child: const Icon(Icons.error),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
        );
      }, loaded: (dynamic bytes) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: Image.memory(
            bytes,
            width: 80,
            height: 80,
          ),
        );
      });
    });
  }
}
