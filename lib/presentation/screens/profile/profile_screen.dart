import 'package:flutter/material.dart';
import 'package:todo_mobx/data/providers/api/profile_api.dart';
import 'package:todo_mobx/data/providers/storage/secure_storage.dart';
import 'package:todo_mobx/data/repositories/profile_repository.dart';
import 'package:todo_mobx/presentation/logic/profile/index.dart';
import 'package:todo_mobx/presentation/screens/profile/widgets/profile_image.dart';
import 'package:todo_mobx/services/http_client/index.dart';

import 'widgets/edit_profile_button.dart';
import 'widgets/profile_data_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileStore _profileStore;

  @override
  void initState() {
    _profileStore = ProfileStore(
        ProfileRepository(ProfileApi(HttpClient()), SecureStorage()));
    Future.microtask(() => _profileStore.getProfileImage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileImage(profileStore: _profileStore),
              const SizedBox(height: 40,),
              EditProfileButton(profileStore: _profileStore),
              ProfileDataForm(profileStore: _profileStore),
            ],
          ),
        ),
      ),
    );
  }
}
