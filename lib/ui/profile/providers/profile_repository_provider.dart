import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/providers/database_provider.dart';
import 'package:humble/core/utils/interests.dart';
import 'package:humble/ui/auth/providers/user_provider.dart';
import 'dart:io' as io;
import '../../../core/providers/storage_provider.dart';
import '../../../core/utils/ids.dart';
import '../models/profile.dart';

final profileRepositoryProvider = Provider(ProfileRepository.new);

class ProfileRepository {
  final Ref _ref;

  ProfileRepository(this._ref);

  Databases get _db => _ref.read(databaseProvider);
  Storage get _storage => _ref.read(storageProvider);

  Future<Profile> getProfile(String id) async {
    try {
      final document = await _db.getDocument(
        databaseId: "main",
        collectionId: "profiles",
        documentId: id,
      );
      return Profile.fromDocument(document);
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Profile>> listProfiles() async {
    try {
      return await _db.listDocuments(
          databaseId: "main", collectionId: "profiles", queries: []).then(
        (value) => value.documents
            .map(
              (e) => Profile.fromDocument(e),
            )
            .toList(),
      );
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> writeProfile(Profile profile, {io.File? file}) async {
    try {
      String? image = file != null
          ? (await uploadImage(
              file,
              Buckets.profiles,
            ))
          : null;
      if (profile.image == null) {
        await _db.createDocument(
          databaseId: DBs.main,
          collectionId: Collections.profiles,
          documentId: profile.id,
          data: profile.copyWith(image: image).toMap(),
        );
      } else {
        await _db.updateDocument(
          databaseId: DBs.main,
          collectionId: Collections.profiles,
          documentId: profile.id,
          data: profile.copyWith(image: image).toMap(),
        );
      }
    } on AppwriteException catch (e) {
      return Future.error(e.message ?? e);
    } catch (e) {
      debugPrint("$e");
      return Future.error(e);
    }
  }

  Future<String> uploadImage(
    io.File file,
    String bucketId, [
    String? id,
  ]) async {
    return (await _storage.createFile(
      bucketId: bucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(
        filename: id,
        path: file.path,
      ),
    ))
        .$id;
  }

  Future<List<Profile>> paginateProfiles(
      {List<String> interests = const [],
      int offset = 0,
      String searchKey = ''}) async {
    try {
      final user = await _ref.read(userProvider.future);
      return await _db.listDocuments(
          databaseId: "main",
          collectionId: "profiles",
          queries: [
            ...Interests.data.keys.map(
              (e) => Query.equal(
                e,
                [
                  'yes',
                  if (!interests.contains(e)) 'no',
                ],
              ),
            ),
            if (searchKey.isNotEmpty) Query.search('name', searchKey),
            Query.notEqual('\$id', [user.$id]),
            Query.limit(5),
            Query.offset(offset),
          ]).then(
        (value) => value.documents
            .map(
              (e) => Profile.fromDocument(e),
            )
            .toList(),
      );
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateFcmToken(
      {required String uid, required String token}) async {
    try {
      await _db.updateDocument(
        databaseId: DBs.main,
        collectionId: Collections.profiles,
        documentId: uid,
        data: {
          'fcmToken': token,
        },
      );
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateOnlineStatus(
      {required String uid, required bool value}) async {
    try {
      await _db.updateDocument(
        databaseId: DBs.main,
        collectionId: Collections.profiles,
        documentId: uid,
        data: {
          'online': value,
        },
      );
    } on AppwriteException catch (e) {
      return Future.error(e.type ?? e.code!);
    } catch (e) {
      return Future.error(e);
    }
  }

}
