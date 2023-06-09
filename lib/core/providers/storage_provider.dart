import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'client_provider.dart';

final storageProvider = Provider((ref)=>Storage(ref.read(clientProvider)));