import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/enums/gender.dart';
import 'package:humble/core/providers/image_provider.dart';
import 'package:humble/core/utils/buckets.dart';
import 'package:humble/core/utils/interests.dart';
import 'package:humble/ui/home/widgets/interest_tag.dart';
import 'package:humble/ui/profile/models/profile.dart';
import 'package:humble/ui/profile/widgets/profile_avatar.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.profile,
  });

  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.profile, extra: profile);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ProfileAvatar(image: profile.image!)),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.labelName,
                          style: context.style.titleMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          profile.occupation,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('📍 ${profile.location}'),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                runSpacing: 6,
                spacing: 6,
                children: [
                  ...profile.interests
                      .map((e) => InterestMiniTag(Interests.label(e))),
                  if (profile.interests.length > 4)
                    InterestMiniTag("+${profile.interests.length - 4}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
