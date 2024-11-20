import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterios/controller/user_view_model.dart';
import 'package:flutterios/view/add_user_view.dart';
import 'package:get/get.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserViewModel viewModel = Get.put(UserViewModel());

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initial data load
    viewModel.fetchUsers();

    // Listen for scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load the next page when reaching the end of the list
        viewModel.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller to avoid memory leaks
    _scrollController.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Users"),
        trailing: GestureDetector(
          onTap: () {
            Get.to(() => AddUserPage());
          },
          child: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      child: Obx(() {
          return CupertinoScrollbar(
            controller: _scrollController,
            child:NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                          _scrollController.position.pixels ==
                              _scrollController.position.maxScrollExtent) {
                        // Load the next page when user reaches the end
                        viewModel.loadNextPage();
                      }
                return false;
              },  
              child:ListView.builder(

              controller: _scrollController,
              itemCount: viewModel.users.length+ 1,
              itemBuilder: (context, index) {
                if (index < viewModel.users.length) {
                final user = viewModel.users[index];
                return CupertinoListTile(
                          leading: Icon(CupertinoIcons.person,color: user.gender=="male"?Colors.blue:Colors.pink,),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: Icon(CupertinoIcons.check_mark_circled_solid,color: user.status=="active"?Colors.green:Colors.grey,),
                        );
              } else {
                return const CupertinoActivityIndicator();
              }
              },
            ),)
          );
        
      }),
    );
  }
}
