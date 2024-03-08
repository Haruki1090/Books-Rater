// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_data_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentsDataControllerNotifierHash() =>
    r'5251567da8e0aea1db43d1a81360b1c4a8679d55';

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

abstract class _$CommentsDataControllerNotifier
    extends BuildlessAutoDisposeStreamNotifier<List<CommentData>> {
  late final BookData bookData;

  Stream<List<CommentData>> build(
    BookData bookData,
  );
}

/// See also [CommentsDataControllerNotifier].
@ProviderFor(CommentsDataControllerNotifier)
const commentsDataControllerNotifierProvider =
    CommentsDataControllerNotifierFamily();

/// See also [CommentsDataControllerNotifier].
class CommentsDataControllerNotifierFamily
    extends Family<AsyncValue<List<CommentData>>> {
  /// See also [CommentsDataControllerNotifier].
  const CommentsDataControllerNotifierFamily();

  /// See also [CommentsDataControllerNotifier].
  CommentsDataControllerNotifierProvider call(
    BookData bookData,
  ) {
    return CommentsDataControllerNotifierProvider(
      bookData,
    );
  }

  @override
  CommentsDataControllerNotifierProvider getProviderOverride(
    covariant CommentsDataControllerNotifierProvider provider,
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
  String? get name => r'commentsDataControllerNotifierProvider';
}

/// See also [CommentsDataControllerNotifier].
class CommentsDataControllerNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<
        CommentsDataControllerNotifier, List<CommentData>> {
  /// See also [CommentsDataControllerNotifier].
  CommentsDataControllerNotifierProvider(
    BookData bookData,
  ) : this._internal(
          () => CommentsDataControllerNotifier()..bookData = bookData,
          from: commentsDataControllerNotifierProvider,
          name: r'commentsDataControllerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentsDataControllerNotifierHash,
          dependencies: CommentsDataControllerNotifierFamily._dependencies,
          allTransitiveDependencies:
              CommentsDataControllerNotifierFamily._allTransitiveDependencies,
          bookData: bookData,
        );

  CommentsDataControllerNotifierProvider._internal(
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
  Stream<List<CommentData>> runNotifierBuild(
    covariant CommentsDataControllerNotifier notifier,
  ) {
    return notifier.build(
      bookData,
    );
  }

  @override
  Override overrideWith(CommentsDataControllerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentsDataControllerNotifierProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<CommentsDataControllerNotifier,
      List<CommentData>> createElement() {
    return _CommentsDataControllerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentsDataControllerNotifierProvider &&
        other.bookData == bookData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CommentsDataControllerNotifierRef
    on AutoDisposeStreamNotifierProviderRef<List<CommentData>> {
  /// The parameter `bookData` of this provider.
  BookData get bookData;
}

class _CommentsDataControllerNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<
        CommentsDataControllerNotifier,
        List<CommentData>> with CommentsDataControllerNotifierRef {
  _CommentsDataControllerNotifierProviderElement(super.provider);

  @override
  BookData get bookData =>
      (origin as CommentsDataControllerNotifierProvider).bookData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
