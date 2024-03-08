// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesControllerNotifierHash() =>
    r'8ca5cb9dc3a79b3bcfaa69e76b659155cd85d8f4';

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

abstract class _$FavoritesControllerNotifier
    extends BuildlessAutoDisposeStreamNotifier<bool> {
  late final BookData bookData;

  Stream<bool> build(
    BookData bookData,
  );
}

/// See also [FavoritesControllerNotifier].
@ProviderFor(FavoritesControllerNotifier)
const favoritesControllerNotifierProvider = FavoritesControllerNotifierFamily();

/// See also [FavoritesControllerNotifier].
class FavoritesControllerNotifierFamily extends Family<AsyncValue<bool>> {
  /// See also [FavoritesControllerNotifier].
  const FavoritesControllerNotifierFamily();

  /// See also [FavoritesControllerNotifier].
  FavoritesControllerNotifierProvider call(
    BookData bookData,
  ) {
    return FavoritesControllerNotifierProvider(
      bookData,
    );
  }

  @override
  FavoritesControllerNotifierProvider getProviderOverride(
    covariant FavoritesControllerNotifierProvider provider,
  ) {
    return call(
      provider.bookData,
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
  String? get name => r'favoritesControllerNotifierProvider';
}

/// See also [FavoritesControllerNotifier].
class FavoritesControllerNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<FavoritesControllerNotifier,
        bool> {
  /// See also [FavoritesControllerNotifier].
  FavoritesControllerNotifierProvider(
    BookData bookData,
  ) : this._internal(
          () => FavoritesControllerNotifier()..bookData = bookData,
          from: favoritesControllerNotifierProvider,
          name: r'favoritesControllerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$favoritesControllerNotifierHash,
          dependencies: FavoritesControllerNotifierFamily._dependencies,
          allTransitiveDependencies:
              FavoritesControllerNotifierFamily._allTransitiveDependencies,
          bookData: bookData,
        );

  FavoritesControllerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookData,
  }) : super.internal();

  final BookData bookData;

  @override
  Stream<bool> runNotifierBuild(
    covariant FavoritesControllerNotifier notifier,
  ) {
    return notifier.build(
      bookData,
    );
  }

  @override
  Override overrideWith(FavoritesControllerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FavoritesControllerNotifierProvider._internal(
        () => create()..bookData = bookData,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookData: bookData,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<FavoritesControllerNotifier, bool>
      createElement() {
    return _FavoritesControllerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoritesControllerNotifierProvider &&
        other.bookData == bookData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FavoritesControllerNotifierRef
    on AutoDisposeStreamNotifierProviderRef<bool> {
  /// The parameter `bookData` of this provider.
  BookData get bookData;
}

class _FavoritesControllerNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<
        FavoritesControllerNotifier, bool> with FavoritesControllerNotifierRef {
  _FavoritesControllerNotifierProviderElement(super.provider);

  @override
  BookData get bookData =>
      (origin as FavoritesControllerNotifierProvider).bookData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
