import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/providers/client_provider.dart';


final accountProvider=  Provider((ref) => Account(ref.read(clientProvider)));