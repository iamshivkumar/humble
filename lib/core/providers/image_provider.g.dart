// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memoryImageHash() => r'f05f47d5d53150de136d14375d9d9005c06e5ac5';

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

typedef MemoryImageRef = AutoDisposeFutureProviderRef<MemoryImage>;

/// See also [memoryImage].
@ProviderFor(memoryImage)
const memoryImageProvider = MemoryImageFamily();

/// See also [memoryImage].
class MemoryImageFamily extends Family<AsyncValue<MemoryImage>> {
  /// See also [memoryImage].
  const MemoryImageFamily();

  /// See also [memoryImage].
  MemoryImageProvider call(
    String bucketId,
    String id,
  ) {
    return MemoryImageProvider(
      bucketId,
      id,
    );
  }

  @override
  MemoryImageProvider getProviderOverride(
    covariant MemoryImageProvider provider,
  ) {
    return call(
      provider.bucketId,
      provider.id,
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
  String? get name => r'memoryImageProvider';
}

/// See also [memoryImage].
class MemoryImageProvider extends AutoDisposeFutureProvider<MemoryImage> {
  /// See also [memoryImage].
  MemoryImageProvider(
    this.bucketId,
    this.id,
  ) : super.internal(
          (ref) => memoryImage(
            ref,
            bucketId,
            id,
          ),
          from: memoryImageProvider,
          name: r'memoryImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$memoryImageHash,
          dependencies: MemoryImageFamily._dependencies,
          allTransitiveDependencies:
              MemoryImageFamily._allTransitiveDependencies,
        );

  final String bucketId;
  final String id;

  @override
  bool operator ==(Object other) {
    return other is MemoryImageProvider &&
        other.bucketId == bucketId &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bucketId.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
