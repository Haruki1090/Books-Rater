import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'description_controller.g.dart';

@riverpod
class DescriptionControllerNotifier extends _$DescriptionControllerNotifier {
  @override
  String build() {
    return '';
  }

  void fetchBookDescription(String bookDescription) {
    state = bookDescription;
  }
}