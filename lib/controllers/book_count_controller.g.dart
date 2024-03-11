// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_count_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookCountControllerNotifierHash() =>
    r'b35be453cf49ef37dd92b970d461976f511a8bc7';

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

abstract class _$BookCountControllerNotifier
    extends BuildlessAutoDisposeStreamNotifier<int> {
  late final User userCredential;

  Stream<int> build(
    User userCredential,
  );
}

/// See also [BookCountControllerNotifier].
@ProviderFor(BookCountControllerNotifier)
const bookCountControllerNotifierProvider = BookCountControllerNotifierFamily();

/// See also [BookCountControllerNotifier].
class BookCountControllerNotifierFamily extends Family<AsyncValue<int>> {
  /// See also [BookCountControllerNotifier].
  const BookCountControllerNotifierFamily();

  /// See also [BookCountControllerNotifier].
  BookCountControllerNotifierProvider call(
    User userCredential,
  ) {
    return BookCountControllerNotifierProvider(
      userCredential,
    );
  }

  @override
  BookCountControllerNotifierProvider getProviderOverride(
    covariant BookCountControllerNotifierProvider provider,
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
  String? get name => r'bookCountControllerNotifierProvider';
}

/// See also [BookCountControllerNotifier].
class BookCountControllerNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<BookCountControllerNotifier,
        int> {
  /// See also [BookCountControllerNotifier].
  BookCountControllerNotifierProvider(
    User userCredential,
  ) : this._internal(
          () => BookCountControllerNotifier()..userCredential = userCredential,
          from: bookCountControllerNotifierProvider,
          name: r'bookCountControllerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookCountControllerNotifierHash,
          dependencies: BookCountControllerNotifierFamily._dependencies,
          allTransitiveDependencies:
              BookCountControllerNotifierFamily._allTransitiveDependencies,
          userCredential: userCredential,
        );

  BookCountControllerNotifierProvider._internal(
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
  Stream<int> runNotifierBuild(
    covariant BookCountControllerNotifier notifier,
  ) {
    return notifier.build(
      userCredential,
    );
  }

  @override
  Override overrideWith(BookCountControllerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookCountControllerNotifierProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<BookCountControllerNotifier, int>
      createElement() {
    return _BookCountControllerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookCountControllerNotifierProvider &&
        other.userCredential == userCredential;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userCredential.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BookCountControllerNotifierRef
    on AutoDisposeStreamNotifierProviderRef<int> {
  /// The parameter `userCredential` of this provider.
  User get userCredential;
}

class _BookCountControllerNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<
        BookCountControllerNotifier, int> with BookCountControllerNotifierRef {
  _BookCountControllerNotifierProviderElement(super.provider);

  @override
  User get userCredential =>
      (origin as BookCountControllerNotifierProvider).userCredential;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
