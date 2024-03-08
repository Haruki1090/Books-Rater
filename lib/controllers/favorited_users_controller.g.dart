// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorited_users_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritedUsersControllerHash() =>
    r'8ac88aa673f8d52e6ba471fbe40c9276a2a2d540';

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

abstract class _$FavoritedUsersController
    extends BuildlessAutoDisposeStreamNotifier<List<FavoritesData>> {
  late final BookData bookData;

  Stream<List<FavoritesData>> build(
    BookData bookData,
  );
}

/// See also [FavoritedUsersController].
@ProviderFor(FavoritedUsersController)
const favoritedUsersControllerProvider = FavoritedUsersControllerFamily();

/// See also [FavoritedUsersController].
class FavoritedUsersControllerFamily
    extends Family<AsyncValue<List<FavoritesData>>> {
  /// See also [FavoritedUsersController].
  const FavoritedUsersControllerFamily();

  /// See also [FavoritedUsersController].
  FavoritedUsersControllerProvider call(
    BookData bookData,
  ) {
    return FavoritedUsersControllerProvider(
      bookData,
    );
  }

  @override
  FavoritedUsersControllerProvider getProviderOverride(
    covariant FavoritedUsersControllerProvider provider,
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
  String? get name => r'favoritedUsersControllerProvider';
}

/// See also [FavoritedUsersController].
class FavoritedUsersControllerProvider
    extends AutoDisposeStreamNotifierProviderImpl<FavoritedUsersController,
        List<FavoritesData>> {
  /// See also [FavoritedUsersController].
  FavoritedUsersControllerProvider(
    BookData bookData,
  ) : this._internal(
          () => FavoritedUsersController()..bookData = bookData,
          from: favoritedUsersControllerProvider,
          name: r'favoritedUsersControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$favoritedUsersControllerHash,
          dependencies: FavoritedUsersControllerFamily._dependencies,
          allTransitiveDependencies:
              FavoritedUsersControllerFamily._allTransitiveDependencies,
          bookData: bookData,
        );

  FavoritedUsersControllerProvider._internal(
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
  Stream<List<FavoritesData>> runNotifierBuild(
    covariant FavoritedUsersController notifier,
  ) {
    return notifier.build(
      bookData,
    );
  }

  @override
  Override overrideWith(FavoritedUsersController Function() create) {
    return ProviderOverride(
      origin: this,
      override: FavoritedUsersControllerProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<FavoritedUsersController,
      List<FavoritesData>> createElement() {
    return _FavoritedUsersControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoritedUsersControllerProvider &&
        other.bookData == bookData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FavoritedUsersControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<FavoritesData>> {
  /// The parameter `bookData` of this provider.
  BookData get bookData;
}

class _FavoritedUsersControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<FavoritedUsersController,
        List<FavoritesData>> with FavoritedUsersControllerRef {
  _FavoritedUsersControllerProviderElement(super.provider);

  @override
  BookData get bookData =>
      (origin as FavoritedUsersControllerProvider).bookData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
