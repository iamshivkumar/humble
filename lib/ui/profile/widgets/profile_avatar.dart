import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/utils/extensions.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../../../core/providers/image_provider.dart';
import '../../../core/utils/ids.dart';
import '../models/profile.dart';

class ProfileCircleAvatar extends ConsumerWidget {
  const ProfileCircleAvatar({super.key, required this.profile, this.radius});
  final Profile profile;
  final double? radius;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final image = profile.image != null
        ? ref
            .watch(memoryImageProvider(Buckets.profiles, profile.image!))
            .asData
            ?.value
        : null;
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: scheme.tertiaryContainer,
          backgroundImage: image,
          child: image == null
              ? Text(
                  profile.name.initial,
                  style: TextStyle(
                    color: scheme.onTertiaryContainer,
                    fontSize: radius,
                  ),
                )
              : null,
        ),
       if(profile.online) Positioned(
          right: 0,
          child: const CircleAvatar(
            radius: 5,
            backgroundColor: Colors.greenAccent,
          ),
        ),
      ],
    );
  }
}

// class ImageAvatar extends ConsumerWidget {
//   const ImageAvatar(
//       {super.key, required this.image, this.radius, this.name = ''});
//   final String image;
//   final double? radius;
//   final String name;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final scheme = Theme.of(context).colorScheme;
//     final memoryImage = ref
//         .watch(memoryImageProvider(Buckets.profiles, image))
//         .asData
//         ?.value;
//     return CircleAvatar(
//       radius: radius,
//       backgroundColor: scheme.tertiaryContainer,
//       backgroundImage: memoryImage,
//       child: memoryImage == null
//           ? Text(
//               name.initial,
//               style: TextStyle(
//                 color: scheme.onTertiaryContainer,
//               ),
//             )
//           : null,
//     );
//   }
// }

class ProfileAvatar extends ConsumerWidget {
  const ProfileAvatar({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageAsync = ref.watch(
      memoryImageProvider(
        Buckets.profiles,
        image,
      ),
    );
    return AspectRatio(
      aspectRatio: 1,
      child: CircleAvatar(
        backgroundImage: imageAsync.asData != null ? imageAsync.value : null,
      ),
    );
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: BoxDecoration(
          color: context.scheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
          image: imageAsync.asData?.value != null
              ? DecorationImage(image: imageAsync.value!)
              : null,
        ),
        child: imageAsync.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : null,
      ),
    );
  }
}
