import 'dart:io';
import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(File?) onImagePicked;
  final String? imageUrl;

  const ProfileImagePicker({
    super.key,
    required this.onImagePicked,
    this.imageUrl,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _imageFile;
  final _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImagePicked(_imageFile);
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  'Select Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Camera option
                      _buildOptionButton(
                        icon: Icons.camera_alt_rounded,
                        label: 'Camera',
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.camera);
                        },
                      ),

                      // Gallery option
                      _buildOptionButton(
                        icon: Icons.photo_library_rounded,
                        label: 'Gallery',
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Cancel button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade100,
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ClipOval(
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
                          : widget.imageUrl != null &&
                                  widget.imageUrl!.isNotEmpty
                              ? Image.network(
                                  widget.imageUrl!,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.person,
                                        size: 60, color: Colors.grey.shade400);
                                  },
                                )
                              : Icon(Icons.person,
                                  size: 60, color: Colors.grey.shade400),
                    ),
            ),
            if (!_isLoading)
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _showImageSourceSheet,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _isLoading ? null : _showImageSourceSheet,
          child: const Text('Change Photo'),
        ),
      ],
    );
  }
}
