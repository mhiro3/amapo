// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProfileScreen extends StatefulWidget {
//   final void Function(String) onImageSelected;

//   const EditProfileScreen({super.key, required this.onImageSelected});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen>
//     with SingleTickerProviderStateMixin {
//   final ImagePicker picker = ImagePicker();
//   File? _selectedImage;
//   bool _isTransitioning = false;

//   Future<void> _pickImage() async {
//     final picked = await picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 800,
//       imageQuality: 85,
//     );

//     if (picked == null) return;

//     final file = File(picked.path);
//     if (!file.existsSync()) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('選択された画像を読み込めませんでした')),
//         );
//       }
//       return;
//     }

//     setState(() {
//       _selectedImage = file;
//       _isTransitioning = true;
//     });

//     await Future.delayed(const Duration(milliseconds: 700));

//     widget.onImageSelected(picked.path);

//     if (mounted) {
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           appBar: AppBar(title: const Text('画像を変更')),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: const Text('ギャラリーから画像を選択'),
//                 ),
//                 const SizedBox(height: 20),
//                 AnimatedOpacity(
//                   opacity: _selectedImage != null ? 1.0 : 0.0,
//                   duration: const Duration(milliseconds: 400),
//                   child: _selectedImage != null
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.file(
//                             _selectedImage!,
//                             width: 160,
//                             height: 160,
//                             fit: BoxFit.cover,
//                             cacheWidth: 300,
//                           ),
//                         )
//                       : const SizedBox(height: 160),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         AnimatedOpacity(
//           opacity: _isTransitioning ? 1.0 : 0.0,
//           duration: const Duration(milliseconds: 400),
//           child: Container(
//             color: Colors.white,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//         ),
//       ],
//     );
//   }
// }