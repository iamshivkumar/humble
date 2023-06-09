import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'client_provider.dart';

final databaseProvider = Provider(
  (ref) =>
      Databases(ref.read(clientProvider)),
);
