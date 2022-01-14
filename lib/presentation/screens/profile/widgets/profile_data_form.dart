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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.microtask(() => widget.profileStore.getUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
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
                            validator: widget.profileStore.emailValidator,
                            onSaved: widget.profileStore.saveEmail,
                            decoration:
                                const InputDecoration(label: Text('Email')),
                          ),
                          TextFormField(
                            initialValue: userData.firstName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: widget.profileStore.nameValidator,
                            onSaved: widget.profileStore.saveName,
                            decoration:
                                const InputDecoration(label: Text('Name')),
                          ),
                          TextFormField(
                            initialValue: userData.age.toString(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: widget.profileStore.ageValidator,
                            onSaved: widget.profileStore.saveAge,
                            decoration:
                                const InputDecoration(label: Text('Age')),
                          ),
                          ElevatedButton.icon(
                            onPressed: _saveForm,
                            icon: const Icon(Icons.save),
                            label: const Text('Save'),
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

  void _saveForm() async {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await widget.profileStore.putUserData();
    }
  }
}
