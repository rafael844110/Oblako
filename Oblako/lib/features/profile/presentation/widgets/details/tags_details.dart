import 'package:cullinarium/core/utils/dialogs/tag_mixin.dart';
import 'package:flutter/material.dart';

class TagsDetails extends StatefulWidget {
  const TagsDetails({
    super.key,
    required this.data,
    required this.title,
    this.onTagSelected,
    this.isViewMode = false,
  });

  final List<String> data;
  final String title;
  final Function(List<String>)? onTagSelected;
  final bool isViewMode;

  @override
  State<TagsDetails> createState() => _TagsDetailsState();
}

class _TagsDetailsState extends State<TagsDetails> with TagMixin {
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List<String>.from(widget.data);
  }

  void _addTag() async {
    final newTag = await showAddTagDialog(context: context);
    if (newTag != null && !_tags.contains(newTag)) {
      setState(() {
        _tags.add(newTag);
      });
      widget.onTagSelected?.call([newTag]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (!widget.isViewMode)
              IconButton(
                onPressed: _addTag,
                icon: const Icon(Icons.add_circle_outline),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _tags.map((tag) {
            return widget.isViewMode
                ? Chip(label: Text(tag))
                : FilterChip(
                    label: Text(tag),
                    selected: false,
                    onSelected: (selected) {
                      widget.onTagSelected?.call([tag]);
                    },
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    checkmarkColor: Theme.of(context).primaryColor,
                  );
          }).toList(),
        ),
      ],
    );
  }
}
