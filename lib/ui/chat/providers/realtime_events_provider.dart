import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:humble/core/utils/ids.dart';
import 'package:humble/ui/chat/models/realtime_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/client_provider.dart';

final realtimeEventsProvider = StreamProvider<RealtimeChange>((ref) {
  final realtime = Realtime(ref.read(clientProvider));
  final controller = StreamController<RealtimeChange>();
  const channels = [
    'databases.${DBs.main}.collections.${Collections.messages}.documents',
    'databases.${DBs.main}.collections.${Collections.chats}.documents',
    'databases.${DBs.main}.collections.${Collections.profiles}.documents',
  ];
  final subscription =  realtime.subscribe(channels).stream.listen((message) {
    for (var channel in channels) {
      final filteredEvents =
          message.events.where((element) => element.contains(channel));
      if (filteredEvents.isNotEmpty) {
        final event = filteredEvents.first;
        final type = event.split('.').last;
        if ([
          RealtimeChange.create,
          RealtimeChange.update,
          RealtimeChange.delete,
        ].contains(type)) {
          final document = Document.fromMap(message.payload);
          controller.add(
            RealtimeChange(
              type: type,
              document: document,
            ),
          );
        }
      }
    }
  });
  
  ref.onDispose(() {
    subscription.cancel();
  });
  return controller.stream;
});
