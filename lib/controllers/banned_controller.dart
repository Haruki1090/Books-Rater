import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'banned_controller.g.dart';

@riverpod
class BannedControllerNotifier extends _$BannedControllerNotifier {
  @override
  bool build() {
    return false;
  }
  void fetchBookBanned(bool bookBanned) {
    state = bookBanned;
  }
}