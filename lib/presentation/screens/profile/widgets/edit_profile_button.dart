import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_mobx/presentation/logic/profile/index.dart';

class EditProfileButton extends StatelessWidget {
  final ProfileStore profileStore;

  const EditProfileButton({Key? key, required this.profileStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) => ImagePickerPopUp(profileStore: profileStore));
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profile Image'));
  }
}

class ImagePickerPopUp extends StatelessWidget {
  final ProfileStore profileStore;

  const ImagePickerPopUp({Key? key, required this.profileStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select-Input',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                final cameraImage = await ImagePicker().pickImage(
                    source: ImageSource.camera, maxHeight: 80, maxWidth: 80);
                if (cameraImage != null) {
                  profileStore.uploadProfileImage(
                      cameraImage.path, await cameraImage.readAsBytes());
                }
              },
              icon: const Icon(Icons.camera),
              label: const Text('From Camera')),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                final cameraImage = await ImagePicker().pickImage(
                    source: ImageSource.gallery, maxWidth: 80, maxHeight: 80);
                if (cameraImage != null) {
                  profileStore.uploadProfileImage(
                      cameraImage.path, await cameraImage.readAsBytes());
                }
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('From Gallery')),
        ],
      ),
    );
  }
}
