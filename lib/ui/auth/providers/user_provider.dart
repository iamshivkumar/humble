
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/client_provider.dart';


final userProvider = FutureProvider<User>(
  (ref) => Account(ref.read(clientProvider)).get(),
);