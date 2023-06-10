// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_sender_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageSenderHash() => r'b7f39faad6ef22db446f3c499d9f74c4ba557163';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef MessageSenderRef = AutoDisposeFutureProviderRef<void>;

/// See also [messageSender].
@ProviderFor(messageSender)
const messageSenderProvider = MessageSenderFamily();

/// See also [messageSender].
class MessageSenderFamily extends Family<AsyncValue<void>> {
  /// See also [messageSender].
  const MessageSenderFamily();

  /// See also [messageSender].
  MessageSenderProvider call(
    dynamic key,
  ) {
    return MessageSenderProvider(
      key,
    );
  }

  @override
  MessageSenderProvider getProviderOverride(
    covariant MessageSenderProvider provider,
  ) {
    return call(
      provider.key,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageSenderProvider';
}

/// See also [messageSender].
class MessageSenderProvider extends AutoDisposeFutureProvider<void> {
  /// See also [messageSender].
  MessageSenderProvider(
    this.key,
  ) : super.internal(
          (ref) => messageSender(
            ref,
            key,
          ),
          from: messageSenderProvider,
          name: r'messageSenderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageSenderHash,
          dependencies: MessageSenderFamily._dependencies,
          allTransitiveDependencies:
              MessageSenderFamily._allTransitiveDependencies,
        );

  final dynamic key;

  @override
  bool operator ==(Object other) {
    return other is MessageSenderProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
