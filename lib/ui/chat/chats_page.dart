// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/chat/providers/chats_provider.dart';
import 'package:humble/ui/chat/widgets/profile_builder.dart';
import 'package:humble/ui/components/async_widget.dart';
import 'package:humble/ui/routes.dart';

import '../auth/providers/user_provider.dart';
import '../profile/widgets/profile_avatar.dart';
import 'chat_page.dart';

class ChatsPage extends ConsumerWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final uid = ref.read(userProvider).value!.$id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(chatsProvider);
        },
        child: AsyncWidget(
          value: ref.watch(chatsProvider),
          data: (data) => data.isEmpty
              ? Center(
                  child: Center(
                    child: Text(
                      "You don't have any messages yet.",
                      style: style.titleMedium,
                    ),
                  ),
                )
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: data
                      .map(
                        (e) => ProfileBuilder(
                          id: e.users.where((element) => element != uid).first,
                          builder: (profile) {
                            return ListTile(
                              onTap: () {
                                context.push(Routes.chat,extra: e.users.firstWhere((element) => element != uid ));
                              },
                              title: Text(profile.name),
                              subtitle: Text(
                                "${e.updatedBy == uid ? "You: " : ""}${e.message}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: ProfileCircleAvatar(profile: profile),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
