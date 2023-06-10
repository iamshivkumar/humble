import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final directoryProvider = FutureProvider(
  (ref) => getApplicationDocumentsDirectory(),
);


