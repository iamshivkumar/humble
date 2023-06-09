

import 'package:appwrite/appwrite.dart';
import 'package:humble/core/providers/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'account_provider.g.dart';

@riverpod
Account account (AccountRef ref) {
  return Account(ref.read(clientProvider));
}