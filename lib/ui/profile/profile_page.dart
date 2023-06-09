import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:humble/core/utils/interests.dart';
import 'package:humble/ui/profile/models/profile.dart';
import 'package:humble/ui/profile/widgets/profile_avatar.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../home/widgets/interest_tag.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.profile,
  });

  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // floatingActionButton: FloatingActionButton.la(
      //   onPressed: () {},
      //   label: Text('Chat'),
      //   icon: Icon(Icons.chat_bubble_outline_rounded),
      // ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: context.media.size.width / 2,
              child: ProfileAvatar(image: profile.image!),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              profile.name,
              style: context.style.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              profile.occupation,
              style: context.style.bodyLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '📍 ${profile.location}',
              style: context.style.bodyLarge,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.scheme.primaryContainer,
                foregroundColor: context.scheme.onPrimaryContainer,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
              ),
              onPressed: () {
                context.push(Routes.chat,extra: profile.id);
              },
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              label: const Text('Chat'),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 8,
                spacing: 8,
                children: profile.interests
                    .map(
                      (e) => InterestTag(
                        Interests.label(e),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
