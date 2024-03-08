import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthControllerNotifier extends _$AuthControllerNotifier {
  User? build() {
    return FirebaseAuth.instance.currentUser;
  }
}