// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fileHash() => r'510091527ddd842adf70a61402a5b5b8fd4cebc3';

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

typedef FileRef = AutoDisposeFutureProviderRef<File>;

/// See also [file].
@ProviderFor(file)
const fileProvider = FileFamily();

/// See also [file].
class FileFamily extends Family<AsyncValue<File>> {
  /// See also [file].
  const FileFamily();

  /// See also [file].
  FileProvider call(
    String bucketId,
    String id,
    String ending,
  ) {
    return FileProvider(
      bucketId,
      id,
      ending,
    );
  }

  @override
  FileProvider getProviderOverride(
    covariant FileProvider provider,
  ) {
    return call(
      provider.bucketId,
      provider.id,
      provider.ending,
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
  String? get name => r'fileProvider';
}

/// See also [file].
class FileProvider extends AutoDisposeFutureProvider<File> {
  /// See also [file].
  FileProvider(
    this.bucketId,
    this.id,
    this.ending,
  ) : super.internal(
          (ref) => file(
            ref,
            bucketId,
            id,
            ending,
          ),
          from: fileProvider,
          name: r'fileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$fileHash,
          dependencies: FileFamily._dependencies,
          allTransitiveDependencies: FileFamily._allTransitiveDependencies,
        );

  final String bucketId;
  final String id;
  final String ending;

  @override
  bool operator ==(Object other) {
    return other is FileProvider &&
        other.bucketId == bucketId &&
        other.id == id &&
        other.ending == ending;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bucketId.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, ending.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
