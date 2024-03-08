// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_books_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myBooksControllerNotifierHash() =>
    r'ab5a7e39389c3587b9ed2da960991f9ad6177e1f';

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

abstract class _$MyBooksControllerNotifier
    extends BuildlessAutoDisposeStreamNotifier<List<BookData>> {
  late final User userCredential;

  Stream<List<BookData>> build(
    User userCredential,
  );
}

/// See also [MyBooksControllerNotifier].
@ProviderFor(MyBooksControllerNotifier)
const myBooksControllerNotifierProvider = MyBooksControllerNotifierFamily();

/// See also [MyBooksControllerNotifier].
class MyBooksControllerNotifierFamily
    extends Family<AsyncValue<List<BookData>>> {
  /// See also [MyBooksControllerNotifier].
  const MyBooksControllerNotifierFamily();

  /// See also [MyBooksControllerNotifier].
  MyBooksControllerNotifierProvider call(
    User userCredential,
  ) {
    return MyBooksControllerNotifierProvider(
      userCredential,
    );
  }

  @override
  MyBooksControllerNotifierProvider getProviderOverride(
    covariant MyBooksControllerNotifierProvider provider,
  ) {
    return call(
      provider.userCredential,
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
  String? get name => r'myBooksControllerNotifierProvider';
}

/// See also [MyBooksControllerNotifier].
class MyBooksControllerNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<MyBooksControllerNotifier,
        List<BookData>> {
  /// See also [MyBooksControllerNotifier].
  MyBooksControllerNotifierProvider(
    User userCredential,
  ) : this._internal(
          () => MyBooksControllerNotifier()..userCredential = userCredential,
          from: myBooksControllerNotifierProvider,
          name: r'myBooksControllerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myBooksControllerNotifierHash,
          dependencies: MyBooksControllerNotifierFamily._dependencies,
          allTransitiveDependencies:
              MyBooksControllerNotifierFamily._allTransitiveDependencies,
          userCredential: userCredential,
        );

  MyBooksControllerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userCredential,
  }) : super.internal();

  final User userCredential;

  @override
  Stream<List<BookData>> runNotifierBuild(
    covariant MyBooksControllerNotifier notifier,
  ) {
    return notifier.build(
      userCredential,
    );
  }

  @override
  Override overrideWith(MyBooksControllerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MyBooksControllerNotifierProvider._internal(
        () => create()..userCredential = userCredential,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userCredential: userCredential,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<MyBooksControllerNotifier,
      List<BookData>> createElement() {
    return _MyBooksControllerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyBooksControllerNotifierProvider &&
        other.userCredential == userCredential;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userCredential.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MyBooksControllerNotifierRef
    on AutoDisposeStreamNotifierProviderRef<List<BookData>> {
  /// The parameter `userCredential` of this provider.
  User get userCredential;
}

class _MyBooksControllerNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<MyBooksControllerNotifier,
        List<BookData>> with MyBooksControllerNotifierRef {
  _MyBooksControllerNotifierProviderElement(super.provider);

  @override
  User get userCredential =>
      (origin as MyBooksControllerNotifierProvider).userCredential;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
