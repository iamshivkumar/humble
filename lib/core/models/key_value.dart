import 'package:equatable/equatable.dart';

class KeyValue extends Equatable {
  final String key;
  final String value;

  const KeyValue(this.key, this.value);

  @override
  List<Object?> get props => [key, value];
}
