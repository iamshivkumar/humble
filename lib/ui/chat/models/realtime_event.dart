import 'package:appwrite/models.dart';

class RealtimeChange {
  final String type;
  final Document document;

  RealtimeChange({
    required this.type,
    required this.document,
  });

  static const create = "create";
  static const update = "update";
  static const delete = "delete";
}
