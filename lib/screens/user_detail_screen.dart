import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/user.dart';
import '../models/post.dart';
import '../models/todo.dart';
import '../repositories/user_repository.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<List<Post>> _postsFuture;
  late Future<List<Todo>> _todosFuture;

  @override
  void initState() {
    super.initState();
    final repo = UserRepository();
    _postsFuture = repo.fetchUserPosts(widget.user.id);
    _todosFuture = repo.fetchUserTodos(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.fullName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.user.image),
              ),
            ),
            const SizedBox(height: 12),
            Center(child: Text(widget.user.email, style: const TextStyle(fontSize: 16))),
            const SizedBox(height: 24),

            const Text("Posts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            FutureBuilder<List<Post>>(
              future: _postsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitCircle(color: Colors.blue, size: 40);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No posts found.');
                }

                return Column(
                  children: snapshot.data!
                      .map((post) => Card(
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  ))
                      .toList(),
                );
              },
            ),

            const SizedBox(height: 24),
            const Text("Todos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            FutureBuilder<List<Todo>>(
              future: _todosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitCircle(color: Colors.green, size: 40);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No todos found.');
                }

                return Column(
                  children: snapshot.data!
                      .map((todo) => ListTile(
                    leading: Icon(todo.completed ? Icons.check_circle : Icons.circle_outlined,
                        color: todo.completed ? Colors.green : Colors.grey),
                    title: Text(todo.todo),
                  ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
