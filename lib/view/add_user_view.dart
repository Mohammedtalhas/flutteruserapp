import 'package:flutter/cupertino.dart';
import 'package:flutterios/controller/user_view_model.dart';
import 'package:flutterios/model/user_model.dart';
import 'package:get/get.dart';

class AddUserPage extends StatelessWidget {
  final UserViewModel viewModel = Get.find();

 

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Add User"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoTextField(
                controller: viewModel.nameController,
                placeholder: "Name",
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: viewModel.emailController,
                placeholder: "Email",
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 20),
              
              // Gender Picker (Dropdown)
              Text("Gender", style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
              CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  viewModel.gender.value = index == 0 ? "male" : "female";
                },
                children: const [
                  Text("Male"),
                  Text("Female"),
                ],
              ),
              const SizedBox(height: 10),

              // Status Picker (Dropdown)
              Text("Status", style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
              CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  viewModel.status.value = index == 0 ? "active" : "inactive";
                },
                children: const [
                  Text("Active"),
                  Text("Inactive"),
                ],
              ),
              const SizedBox(height: 20),

              // Add User Button
              CupertinoButton.filled(
                onPressed: () {
                  final user = User(
                    name: viewModel.nameController.text,
                    email: viewModel.emailController.text,
                    gender: viewModel.gender.value,
                    status: viewModel.status.value,
                  );
                  viewModel.addUser(user);
                  Get.back(); // Navigate back
                },
                child: const Text("Add User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
