// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_count_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentsCountControllerNotifierHash() =>
    r'0f2d9c7418b92c0bdf5d0fa1554e788ade6c2baa';

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

abstract class _$CommentsCountControllerNotifier
    extends BuildlessAutoDisposeStreamNotifier<int> {
  late final BookData bookData;

  Stream<int> build(
    BookData bookData,
  );
}

/// See also [CommentsCountControllerNotifier].
@ProviderFor(CommentsCountControllerNotifier)
const commentsCountControllerNotifierProvider =
    CommentsCountControllerNotifierFamily();

/// See also [CommentsCountControllerNotifier].
class CommentsCountControllerNotifierFamily extends Family<AsyncValue<int>> {
  /// See also [CommentsCountControllerNotifier].
  const CommentsCountControllerNotifierFamily();

  /// See also [CommentsCountControllerNotifier].
  CommentsCountControllerNotifierProvider call(
    BookData bookData,
  ) {
    return CommentsCountControllerNotifierProvider(
      bookData,
    );
  }

  @override
  CommentsCountControllerNotifierProvider getProviderOverride(
    covariant CommentsCountControllerNotifierProvider provider,
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
  String? get name => r'commentsCountControllerNotifierProvider';
}

/// See also [CommentsCountControllerNotifier].
class CommentsCountControllerNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<
        CommentsCountControllerNotifier, int> {
  /// See also [CommentsCountControllerNotifier].
  CommentsCountControllerNotifierProvider(
    BookData bookData,
  ) : this._internal(
          () => CommentsCountControllerNotifier()..bookData = bookData,
          from: commentsCountControllerNotifierProvider,
          name: r'commentsCountControllerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentsCountControllerNotifierHash,
          dependencies: CommentsCountControllerNotifierFamily._dependencies,
          allTransitiveDependencies:
              CommentsCountControllerNotifierFamily._allTransitiveDependencies,
          bookData: bookData,
        );

  CommentsCountControllerNotifierProvider._internal(
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
    covariant CommentsCountControllerNotifier notifier,
  ) {
    return notifier.build(
      bookData,
    );
  }

  @override
  Override overrideWith(CommentsCountControllerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentsCountControllerNotifierProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<CommentsCountControllerNotifier, int>
      createElement() {
    return _CommentsCountControllerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentsCountControllerNotifierProvider &&
        other.bookData == bookData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CommentsCountControllerNotifierRef
    on AutoDisposeStreamNotifierProviderRef<int> {
  /// The parameter `bookData` of this provider.
  BookData get bookData;
}

class _CommentsCountControllerNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<
        CommentsCountControllerNotifier,
        int> with CommentsCountControllerNotifierRef {
  _CommentsCountControllerNotifierProviderElement(super.provider);

  @override
  BookData get bookData =>
      (origin as CommentsCountControllerNotifierProvider).bookData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
