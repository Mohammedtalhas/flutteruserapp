import 'package:dio/dio.dart';
import 'package:flutterios/model/user_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://gorest.co.in/public/v2/",
      headers: {
        "Authorization": "Bearer 4e6f3e9249990a534396d0633844031a0f712334613d6142b77c8584f5551f94", // Replace with your token
      },
    ),
  );

  Future<List<User>> fetchUsers({int page = 1, int perPage = 20}) async {
    try {
      // Fetch users with pagination parameters
      final response = await _dio.get(
        "users",
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      // Parse the response data into a list of users
      List<User> users = (response.data as List)
          .map((userData) => User.fromJson(userData))
          .toList();

      return users;
    } catch (e) {
      throw Exception("Failed to load users: $e");
    }
  }

  Future<void> addUser(Map<String, dynamic> userData) async {
    try {
      await _dio.post("users", data: userData);
    } catch (e) {
      throw Exception("Failed to add user");
    }
  }
}
