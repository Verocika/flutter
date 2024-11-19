import 'dart:io';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final Map<String, String> task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          task['title'] ?? 'Detail Tugas',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(task['image']),
            const SizedBox(height: 16),
            Text(
              task['title'] ?? 'Tanpa Judul',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              task['description'] ?? 'Tidak ada deskripsi.',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _buildImage(String? imagePath) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: imagePath == null || imagePath.isEmpty
          ? _imageErrorWidget()
          : Uri.tryParse(imagePath)?.isAbsolute ?? false
              ? Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _imageErrorWidget(),
                )
              : Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _imageErrorWidget(),
                ),
    );
  }

  Widget _imageErrorWidget() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(
        Icons.broken_image,
        size: 100,
        color: Colors.grey,
      ),
    );
  }
}
