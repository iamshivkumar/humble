import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/providers/image_provider.dart';
import 'package:humble/core/utils/buckets.dart';
import 'package:humble/ui/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';

class AvatarEditor extends ConsumerWidget {
  const AvatarEditor(
      {super.key, this.file, this.image, required this.onChanged});

  final String? image;
  final File? file;
  final ValueChanged<File> onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageData = image != null
        ? ref.watch(memoryImageProvider(Buckets.profiles, image!)).asData?.value
        : null;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: context.media.size.width / 2.5,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.scheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                      image: file != null || imageData != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: (file != null
                                  ? FileImage(file!)
                                  : imageData!) as ImageProvider,
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final picked = await context.pickAndCrop(
                              3 / 4, ImageSource.camera);
                          if (picked != null) {
                            onChanged(picked);
                          }
                        },
                        child: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final picked = await context.pickAndCrop(
                              3 / 4, ImageSource.gallery);
                          if (picked != null) {
                            onChanged(picked);
                          }
                        },
                        child: const Icon(Icons.photo_outlined),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
