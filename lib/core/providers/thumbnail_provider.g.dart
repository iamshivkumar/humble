// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$thumbnailHash() => r'9a5fdfe4f9dac6b2c574e489e135f53d665f8c30';

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

typedef ThumbnailRef = AutoDisposeFutureProviderRef<String?>;

/// See also [thumbnail].
@ProviderFor(thumbnail)
const thumbnailProvider = ThumbnailFamily();

/// See also [thumbnail].
class ThumbnailFamily extends Family<AsyncValue<String?>> {
  /// See also [thumbnail].
  const ThumbnailFamily();

  /// See also [thumbnail].
  ThumbnailProvider call(
    String path,
  ) {
    return ThumbnailProvider(
      path,
    );
  }

  @override
  ThumbnailProvider getProviderOverride(
    covariant ThumbnailProvider provider,
  ) {
    return call(
      provider.path,
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
  String? get name => r'thumbnailProvider';
}

/// See also [thumbnail].
class ThumbnailProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [thumbnail].
  ThumbnailProvider(
    this.path,
  ) : super.internal(
          (ref) => thumbnail(
            ref,
            path,
          ),
          from: thumbnailProvider,
          name: r'thumbnailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$thumbnailHash,
          dependencies: ThumbnailFamily._dependencies,
          allTransitiveDependencies: ThumbnailFamily._allTransitiveDependencies,
        );

  final String path;

  @override
  bool operator ==(Object other) {
    return other is ThumbnailProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
