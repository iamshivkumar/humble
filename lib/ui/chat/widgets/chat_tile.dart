import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/chat/models/chat.dart';
import 'package:humble/ui/chat/widgets/profile_builder.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../../auth/providers/user_provider.dart';
import '../../profile/widgets/profile_avatar.dart';
import '../../routes.dart';

class ChatTile extends ConsumerWidget {
  const ChatTile({super.key, required this.e});
  final Chat e;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.read(userProvider).value!.$id;
    final subtitleText = e.message?.subtitleText(uid);
    final showCount = e.message?.receiverId == uid && e.unseen != 0;
    return ProfileBuilder(
      id: e.users.where((element) => element != uid).first,
      builder: (profile) {
        return ListTile(
          onTap: () {
            context.push(Routes.chat,
                extra: e.users.firstWhere((element) => element != uid));
          },
          title: Row(
            children: [
              Flexible(
                child: Text(profile.name),
              ),
              if (e.typing[profile.id] ?? false)
                Text(
                  '  Typing...',
                  style: context.style.labelSmall!.copyWith(
                    color: context.scheme.primary,
                  ),
                ),
            ],
          ),
          subtitle: subtitleText != null
              ? Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitleText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: showCount ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                    if (showCount)
                      CircleAvatar(
                        backgroundColor: context.scheme.secondary,
                        radius: 8,
                        child: Text(
                          '${e.unseen}',
                          style: TextStyle(
                            fontSize: 10,
                            color: context.scheme.onSecondary,
                          ),
                        ),
                      ),
                  ],
                )
              : null,
          leading: ProfileCircleAvatar(profile: profile),
        );
      },
    );
  }
}
