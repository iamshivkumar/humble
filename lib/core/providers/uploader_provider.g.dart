// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploader_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$uploaderHash() => r'a14c86cb2a0200781ea4cea3b90526a28d1dbb54';

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

typedef UploaderRef = AutoDisposeStreamProviderRef<UploadProgress>;

/// See also [uploader].
@ProviderFor(uploader)
const uploaderProvider = UploaderFamily();

/// See also [uploader].
class UploaderFamily extends Family<AsyncValue<UploadProgress>> {
  /// See also [uploader].
  const UploaderFamily();

  /// See also [uploader].
  UploaderProvider call({
    required File file,
    String? id,
    required String bucketId,
  }) {
    return UploaderProvider(
      file: file,
      id: id,
      bucketId: bucketId,
    );
  }

  @override
  UploaderProvider getProviderOverride(
    covariant UploaderProvider provider,
  ) {
    return call(
      file: provider.file,
      id: provider.id,
      bucketId: provider.bucketId,
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
  String? get name => r'uploaderProvider';
}

/// See also [uploader].
class UploaderProvider extends AutoDisposeStreamProvider<UploadProgress> {
  /// See also [uploader].
  UploaderProvider({
    required this.file,
    this.id,
    required this.bucketId,
  }) : super.internal(
          (ref) => uploader(
            ref,
            file: file,
            id: id,
            bucketId: bucketId,
          ),
          from: uploaderProvider,
          name: r'uploaderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uploaderHash,
          dependencies: UploaderFamily._dependencies,
          allTransitiveDependencies: UploaderFamily._allTransitiveDependencies,
        );

  final File file;
  final String? id;
  final String bucketId;

  @override
  bool operator ==(Object other) {
    return other is UploaderProvider &&
        other.file == file &&
        other.id == id &&
        other.bucketId == bucketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, bucketId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
