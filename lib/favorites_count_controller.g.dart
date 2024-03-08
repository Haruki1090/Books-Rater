// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_count_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesCountControllerNotifierHash() =>
    r'9dfb546b3cb78690fb10cd80fa986cf5dca7e34c';

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

abstract class _$FavoritesCountControllerNotifier
    extends BuildlessAutoDisposeStreamNotifier<int> {
  late final BookData bookData;

  Stream<int> build(
    BookData bookData,
  );
}

/// See also [FavoritesCountControllerNotifier].
@ProviderFor(FavoritesCountControllerNotifier)
const favoritesCountControllerNotifierProvider =
    FavoritesCountControllerNotifierFamily();

/// See also [FavoritesCountControllerNotifier].
class FavoritesCountControllerNotifierFamily extends Family<AsyncValue<int>> {
  /// See also [FavoritesCountControllerNotifier].
  const FavoritesCountControllerNotifierFamily();

  /// See also [FavoritesCountControllerNotifier].
  FavoritesCountControllerNotifierProvider call(
    BookData bookData,
  ) {
    return FavoritesCountControllerNotifierProvider(
      bookData,
    );
  }

  @override
  FavoritesCountControllerNotifierProvider getProviderOverride(
    covariant FavoritesCountControllerNotifierProvider provider,
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
  String? get name => r'favoritesCountControllerNotifierProvider';
}

/// See also [FavoritesCountControllerNotifier].
class FavoritesCountControllerNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<
        FavoritesCountControllerNotifier, int> {
  /// See also [FavoritesCountControllerNotifier].
  FavoritesCountControllerNotifierProvider(
    BookData bookData,
  ) : this._internal(
          () => FavoritesCountControllerNotifier()..bookData = bookData,
          from: favoritesCountControllerNotifierProvider,
          name: r'favoritesCountControllerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$favoritesCountControllerNotifierHash,
          dependencies: FavoritesCountControllerNotifierFamily._dependencies,
          allTransitiveDependencies:
              FavoritesCountControllerNotifierFamily._allTransitiveDependencies,
          bookData: bookData,
        );

  FavoritesCountControllerNotifierProvider._internal(
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
  Stream<int> runNotifierBuild(
    covariant FavoritesCountControllerNotifier notifier,
  ) {
    return notifier.build(
      bookData,
    );
  }

  @override
  Override overrideWith(FavoritesCountControllerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FavoritesCountControllerNotifierProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<FavoritesCountControllerNotifier,
      int> createElement() {
    return _FavoritesCountControllerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoritesCountControllerNotifierProvider &&
        other.bookData == bookData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FavoritesCountControllerNotifierRef
    on AutoDisposeStreamNotifierProviderRef<int> {
  /// The parameter `bookData` of this provider.
  BookData get bookData;
}

class _FavoritesCountControllerNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<
        FavoritesCountControllerNotifier,
        int> with FavoritesCountControllerNotifierRef {
  _FavoritesCountControllerNotifierProviderElement(super.provider);

  @override
  BookData get bookData =>
      (origin as FavoritesCountControllerNotifierProvider).bookData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
