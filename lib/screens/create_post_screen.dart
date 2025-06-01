import 'package:flutter/material.dart';
import '../models/post.dart';

class CreatePostScreen extends StatefulWidget {
  final int userId;
  final Function(Post) onPostCreated;

  const CreatePostScreen({
    super.key,
    required this.userId,
    required this.onPostCreated,
  });

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        body: _bodyController.text,
        userId: widget.userId,
      );

      widget.onPostCreated(newPost);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Title is required" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: "Body"),
                maxLines: 4,
                validator: (value) => value!.isEmpty ? "Body is required" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitPost,
                child: const Text("Add Post"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
