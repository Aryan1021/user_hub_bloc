import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/post.dart';
import '../models/todo.dart';

class UserRepository {
  static const _baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers({int limit = 10, int skip = 0, String? search}) async {
    try {
      final uri = Uri.parse('$_baseUrl/users')
          .replace(queryParameters: {
        'limit': '$limit',
        'skip': '$skip',
        if (search != null && search.isNotEmpty) 'q': search,
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> usersJson = data['users'];
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> fetchUserPosts(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/posts/user/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> postsJson = data['posts'];
        return postsJson.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Todo>> fetchUserTodos(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/todos/user/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> todosJson = data['todos'];
        return todosJson.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      rethrow;
    }
  }
}
