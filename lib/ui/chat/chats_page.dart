// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/chat/providers/chats_provider.dart';
import 'package:humble/ui/chat/widgets/chat_tile.dart';
import 'package:humble/ui/components/async_widget.dart';

class ChatsPage extends ConsumerWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
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
                        (e) => ChatTile(e: e)
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
