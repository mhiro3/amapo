import 'dart:io';
import 'package:flutter/material.dart';

class ProfileSummary extends StatelessWidget {
  final String? iconPath;
  final String username;
  final VoidCallback onBGPressed;
  final VoidCallback? onIconPressed; // 追加

  const ProfileSummary({
    super.key,
    required this.iconPath,
    required this.username,
    required this.onBGPressed,
    this.onIconPressed, // 追加
  });

  @override
  Widget build(BuildContext context) {
    final file = iconPath != null ? File(iconPath!) : null;
    final ImageProvider<Object> imageProvider = (file != null && file.existsSync())
        ? FileImage(file)
        : const AssetImage('assets/images/default_avatar.png');

    return Row(
      children: [
        GestureDetector(
          onTap: onIconPressed, // ここを修正
          child: CircleAvatar(
            radius: 30,
            backgroundImage: imageProvider,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(username, style: const TextStyle(fontSize: 18)),
              ElevatedButton(
                onPressed: onBGPressed,
                child: const Text('BG'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}