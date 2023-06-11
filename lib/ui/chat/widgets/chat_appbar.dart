import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/chat/providers/chats_provider.dart';
import 'package:humble/ui/chat/widgets/profile_builder.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../../profile/widgets/profile_avatar.dart';
import '../models/chat.dart';

class ChatAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.receiverId,
    required this.chatId,
  });

  final String  receiverId;
  final String chatId;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final chat = ref.watch(chatsProvider).asData?.value.cast<Chat?>()
            .firstWhere((element) => element?.id == chatId, orElse: () => null);
    return AppBar(
      titleSpacing: 0,
      title: ProfileBuilder(
        id: receiverId,
        builder: (profile) => ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(profile.name),
          leading: ProfileCircleAvatar(profile: profile),
          subtitle: (chat?.typing[receiverId]??false)? Text(
            'Typing...',
            style: context.style.labelSmall!.copyWith(
              color: context.scheme.secondary,
            ),
          ): null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
