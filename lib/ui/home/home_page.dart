import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/utils/interests.dart';
import 'package:humble/ui/components/app_search_bar.dart';
import 'package:humble/ui/home/providers/async_paginate_profiles.dart';
import 'package:humble/ui/home/widgets/match_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(paginateProfilesProvider);
    final notifier = ref.read(paginateProfilesProvider.notifier);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Humble"),
      //   actions: [
      //     // IconButton(onPressed: (){}, icon: Icon(Icons.search),),
      //   ],
      // ),
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppSearchBar(
                value: notifier.debouncer.value,
                onChanged: (v) {
                  notifier.debouncer.value = v;
                },
                hintText: "Search humble profiles",
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: Interests.data.entries
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(e.value),
                        selected: model.interests.contains(e.key),
                        onSelected: (v) {
                          notifier.toggleInterest(e.key);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: model.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (!notifier.busy &&
                          notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent &&
                          notification.metrics.maxScrollExtent > 0) {
                        notifier.loadMore();
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        notifier.refresh();
                      },
                      child: ListView(
                          padding: const EdgeInsets.all(12),
                          children: [
                            ...model.profiles.map(
                              (e) => MatchCard(profile: e),
                            ),
                            if (model.moreLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
