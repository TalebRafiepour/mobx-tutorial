import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/presentation/logic/profile/index.dart';

class ProfileDataForm extends StatefulWidget {
  final ProfileStore profileStore;

  const ProfileDataForm({Key? key, required this.profileStore})
      : super(key: key);

  @override
  State<ProfileDataForm> createState() => _ProfileDataFormState();
}

class _ProfileDataFormState extends State<ProfileDataForm> {
  @override
  void initState() {
    Future.microtask(() => widget.profileStore.getUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Expanded(
        child: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Observer(
              builder: (_) =>
                  widget.profileStore.profileUserDataState.when(noData: () {
                    return const Center(child: Text('No Data'));
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }, loaded: (userData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: userData.email,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                const InputDecoration(label: Text('Email')),
                          ),
                          TextFormField(
                            initialValue: userData.firstName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(label: Text('Name')),
                          ),
                          TextFormField(
                            initialValue: userData.age.toString(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(label: Text('Age')),
                          ),
                        ]
                            .expand((element) => [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: element,
                                  )
                                ])
                            .toList(),
                      ),
                    );
                  }, error: (errorMessage) {
                    return Center(child: Text(errorMessage));
                  })),
        )),
      ),
    );
  }
}
