import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets/profile_summary.dart';
import 'widgets/image_grid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? iconPath;
  String? backgroundPath;
  List<String> favoriteImages = [];

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      for (final path in favoriteImages.take(6)) {
        final file = File(path);
        if (file.existsSync()) {
          await Future.delayed(const Duration(milliseconds: 200));
          if (!mounted) return;
          precacheImage(FileImage(file), context);
        }
      }

      if (backgroundPath != null && File(backgroundPath!).existsSync()) {
        if (!mounted) return;
        precacheImage(FileImage(File(backgroundPath!)), context);
      }

      if (iconPath != null && File(iconPath!).existsSync()) {
        if (!mounted) return;
        precacheImage(FileImage(File(iconPath!)), context);
      }
    });
  }

  // 映えピクを追加するメソッド
  Future<void> _pickAndAddImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );

    if (picked == null) return;

    final file = File(picked.path);
    if (!file.existsSync()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('選択された画像が存在しません')),
      );
      return;
    }

    if (!mounted) return;
    setState(() {
      favoriteImages.add(picked.path);
    });
  }

  // 背景画像を選択するメソッド
  Future<void> _pickBGImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      imageQuality: 80,
    );

    if (picked == null) return;

    final file = File(picked.path);
    if (!file.existsSync()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('背景画像が見つかりません')),
      );
      return;
    }

    if (!mounted) return;
    setState(() {
      backgroundPath = picked.path;
    });
  }

  // 追加: アイコン画像を選択するメソッド
  Future<void> _pickIconImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      imageQuality: 80,
    );

    if (picked == null) return;

    final file = File(picked.path);
    if (!file.existsSync()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('アイコン画像が見つかりません')),
      );
      return;
    }

    if (!mounted) return;
    setState(() {
      iconPath = picked.path;
    });
  }

  // 追加: 自分の評価したお店一覧を表示するためのメソッド
  Future<void> _pickAddPatisserie() async {
    // ここに自分の評価したお店一覧を表示する処理を追加
    // 例えば、別の画面に遷移するなど
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('自分の評価したお店一覧機能は未実装です')),
    );
  }

  // 画面のビルドメソッド
  @override
  Widget build(BuildContext context) {
    final limitedImages = favoriteImages.take(12).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('プロフィール')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundPath != null && File(backgroundPath!).existsSync()
                ? FileImage(File(backgroundPath!))
                : const AssetImage('assets/images/default_bg.jpg') as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xE6FFFFFF),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ProfileSummary(
                    iconPath: iconPath,
                    username: 'ユーザー',
                    onBGPressed: _pickBGImage,
                    onIconPressed: _pickIconImage, // 追加
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _pickAddPatisserie, 
                    child: Text('自分の評価したお店一覧')
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickAndAddImage,
                    child: const Text('映えピクを追加'),
                  ),
                  const SizedBox(height: 16),
                  ImageGrid(imagePaths: limitedImages),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}