import 'package:flutter/widgets.dart';
import 'package:flutterios/model/user_model.dart';
import 'package:flutterios/service/api_service.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController {
  final ApiService _apiService = ApiService();

  var users = <User>[].obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;
     // Loading state
  var currentPage = 1.obs;   
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  RxString gender = "male".obs;
  RxString status = "active".obs;
  // Future<void> fetchUsers() async {
  //   isLoading.value = true;
  //   try {
  //     final data = await _apiService.fetchUsers();
  //     users.value = data.map((e) => User.fromJson(e)).toList();
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> fetchUsers({int page = 1, int perPage = 20}) async {
    try {
      isLoading(true);
      List<User> newUsers  = await _apiService.fetchUsers(page: page, perPage: perPage);
      
      if (page == 1) {
        // If it's the first page, clear existing users
        users.assignAll(newUsers);
      } else {
        // Append new users to the existing list for subsequent pages
        users.addAll(newUsers);
      }
    } catch (e) {
      errorMessage('Failed to load users');
      Get.snackbar("Error", "Failed to load users");
    } finally {
      isLoading(false);
    }
  }

  // Method to load the next page of users
  Future<void> loadNextPage() async {
    currentPage.value++;
    await fetchUsers(page: currentPage.value);
  }
  Future<void> addUser(User user) async {
    print({
        "name": user.name,
        "email": user.email,
        "gender": user.gender,
        "status": user.status,
      });
    try {
      await _apiService.addUser({
        "name": user.name,
        "email": user.email,
        "gender": user.gender,
        "status": user.status,
      });
      fetchUsers(); // Refresh user list
    } catch (e) {

      Get.snackbar("Error", "Failed to add users");
      errorMessage.value = e.toString();
    }
  }
}
