import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/providers/database_provider.dart';
import 'package:humble/core/providers/storage_provider.dart';
import 'package:humble/core/utils/buckets.dart';
import 'package:path_provider/path_provider.dart';

import '../models/chat.dart';
import '../models/message.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(ref));

class ChatRepository {
  final Ref _ref;

  ChatRepository(this._ref);

  Databases get _db => _ref.read(databaseProvider);

  Future<void> sendMessage(Message message,
      {bool isNew = false, io.File? file, int unseen = 0}) async {
    Future<void> updateMessage() async {
      await _db.updateDocument(
        databaseId: "main",
        collectionId: "chats",
        documentId: message.chatId,
        data: {
          "updatedBy": message.senderId,
          "message": message.toJson(),
          "unseen": unseen + 1,
        },
      );
    }

    if (message.attachment != null) {
      final dir = await getApplicationDocumentsDirectory();
      final f = File(
          '${dir.path}/${message.attachment!.value}.${message.attachment!.ending}');
      await f.writeAsBytes(await file!.readAsBytes());
    }

    try {
      await _db.createDocument(
        databaseId: "main",
        collectionId: "messages",
        documentId: ID.unique(),
        data: message.copyWith(attachment: message.attachment).toMap(),
      );
    } on AppwriteException catch (e) {
      print(e.code);
      print(e);
    }

    if (isNew == true) {
      final chat = Chat(
        id: '',
        message: message,
        users: [message.senderId, message.receiverId],
        createdBy: message.senderId,
        createdAt: DateTime.now(),
      );
      try {
        await _db.createDocument(
          databaseId: "main",
          collectionId: "chats",
          documentId: message.chatId,
          data: chat.toMap(),
        );
      } on AppwriteException catch (e) {
        if (e.type == 'document_already_exists') {
          updateMessage();
        } else {
          return Future.error(e.type ?? e.code.toString());
        }
      }
    } else {
      updateMessage();
    }
  }

  Future<String> uploadImage(
    io.File file, [
    String? id,
  ]) async {
    return (await _ref.read(storageProvider).createFile(
              bucketId: Buckets.attachments,
              fileId: id ?? ID.unique(),
              file: InputFile.fromPath(
                filename: '$id.${file.path.split('.').last}',
                path: file.path,
              ),
            ))
        .$id;
  }

  Future<List<Chat>> listChats(String uid) => _db.listDocuments(
        databaseId: DBs.main,
        collectionId: Collections.chats,
        queries: [
          Query.search('users', uid),
        ],
      ).then(
        (value) => value.documents
            .map(
              (e) => Chat.fromDocument(e),
            )
            .toList(),
      );

  Future<List<Message>> paginateMessages(String chatId,
      {int offset = 0, required int limit}) async {
    try {
      return await _db.listDocuments(
        databaseId: DBs.main,
        collectionId: Collections.messages,
        queries: [
          Query.equal('chatId', [chatId]),
          Query.limit(limit),
          Query.offset(offset),
          Query.orderDesc(r'$createdAt'),
        ],
      ).then(
        (value) => value.documents
            .map(
              (e) => Message.fromMap(e.data),
            )
            .toList(),
      );
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> seenMessage(String id) async {
    try {
      await _db.updateDocument(
          databaseId: DBs.main,
          collectionId: Collections.messages,
          documentId: id,
          data: {
            'seen': true,
          });
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> makeUnseenZero(String id) async {
    try {
      await _db.updateDocument(
          databaseId: DBs.main,
          collectionId: Collections.chats,
          documentId: id,
          data: {
            'unseen': 0,
          });
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }
}
