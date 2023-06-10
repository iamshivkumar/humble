import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/home/models/debouncer.dart';
import 'package:humble/ui/home/models/paginate_profiles_state.dart';
import 'package:humble/ui/profile/providers/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_paginate_profiles.g.dart';

@riverpod
class PaginateProfiles extends _$PaginateProfiles {
  @override
  PaginateProfileState build() {
    //TODO
    final user = ref.watch(userProvider).asData?.value;
    ref.keepAlive();
    debouncer = Debouncer(const Duration(milliseconds: 500), (value) {
      state = state.copyWith(
        loading: true,
      );
      _fetch(
        interests: state.interests,
        searchKey: value,
        offset: 0,
      );
    });
    _fetch();
    return PaginateProfileState();
  }

  late Debouncer debouncer;

  bool busy = false;

  ProfileRepository get _repository => ref.read(profileRepositoryProvider);

  void _fetch(
      {List<String> interests = const [],
      int offset = 0,
      String searchKey = ''}) async {
    final newProfiles = await _repository.paginateProfiles(
      interests: interests,
      offset: offset,
      searchKey: searchKey,
    );
    final profiles = [if (offset != 0) ...state.profiles, ...newProfiles];
    state = state.copyWith(
      profiles: profiles,
      loading: false,
      moreLoading: profiles.length == 5 ? true : false,
    );
    busy = false;
  }

  void refresh() {
    if (!state.loading) {
      state = state.copyWith(
        loading: true,
      );
    }
    _fetch(
      interests: state.interests,
      offset: 0,
      searchKey: debouncer.value,
    );
  }

  void loadMore() async {
    _fetch(
      interests: state.interests,
      offset: state.profiles.length,
      searchKey: debouncer.value,
    );
  }

  void toggleInterest(String v) {
    state = state.copyWith(
      interests: state.interests.contains(v)
          ? state.interests.where((element) => element != v).toList()
          : [...state.interests, v],
      loading: true,
    );
    refresh();
  }
}
