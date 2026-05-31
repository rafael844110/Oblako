import 'dart:io';
import 'package:cullinarium/core/utils/dialogs/custom_bottom_sheet.dart';
import 'package:cullinarium/core/widgets/layout/single_image_holder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHolder extends StatefulWidget {
  final int maxImages;
  final Function(List<File>)? onImagesChanged;
  final List<String>? images;
  final String? title;

  const ImageHolder({
    super.key,
    this.maxImages = 5,
    this.onImagesChanged,
    this.images,
    this.title,
  });

  @override
  State<ImageHolder> createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> with CustomBottomSheets {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.images != null) {
      _images.addAll(widget.images!.map((path) => File(path)));
      widget.onImagesChanged?.call(_images);
    }
  }

  Future<void> _pickFromSource(ImageSource source) async {
    if (_images.length >= widget.maxImages) return;

    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
      widget.onImagesChanged?.call(_images);
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    widget.onImagesChanged?.call(_images);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPicker = _images.length < widget.maxImages;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              if (hasPicker)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SingleImageHolder(
                    image: null,
                    onPick: () => showImagePickerSheet(
                      context: context,
                      onPickFromGallery: () async {
                        Navigator.of(context).pop();
                        await _pickFromSource(ImageSource.gallery);
                      },
                      onPickFromCamera: () async {
                        Navigator.of(context).pop();
                        await _pickFromSource(ImageSource.camera);
                      },
                    ),
                    onRemove: () {},
                  ),
                ),
              ..._images.map((image) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SingleImageHolder(
                      image: image,
                      onPick: () {},
                      onRemove: () => _removeImage(_images.indexOf(image)),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
