import 'dart:io';
import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imagePaths;

  const ImageGrid({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: imagePaths.map((path) {
        final file = File(path);
        final exists = file.existsSync();

        return Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            image: exists
                ? DecorationImage(image: FileImage(file), fit: BoxFit.cover)
                : null,
            color: exists ? null : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: exists
              ? null
              : const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
        );
      }).toList(),
    );
  }
}