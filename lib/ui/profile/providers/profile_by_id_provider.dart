import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/chat/providers/realtime_events_provider.dart';
import 'package:humble/ui/profile/providers/profile_repository_provider.dart';

import '../../../core/utils/ids.dart';
import '../models/profile.dart';

final profileByIdProvider = StreamProvider.family<Profile, String>((ref, id) {
  final controller = StreamController<Profile>();
  ref.listen(realtimeEventsProvider.select((value) => value.asData?.value),
      (_, next) {
    if (next?.document.$collectionId == Collections.profiles &&
        next!.document.$id == id) {
      controller.add(Profile.fromDocument(next.document));
    }
  });
  ref.read(profileRepositoryProvider).getProfile(id).then((value) {
    controller.add(value);
  }).catchError((e) {
    controller.addError(e);
  });
  return controller.stream;
});
