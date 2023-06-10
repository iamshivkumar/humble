

import 'package:hive/hive.dart';
import 'package:humble/ui/chat/models/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final messagesBoxProvider = FutureProvider<Box<Message>>((ref) async {
  final box = await Hive.openBox<Message>('messages');
  ref.onDispose(() {
    box.close();
  });
  return box;
});