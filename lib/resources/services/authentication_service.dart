
import 'package:librivox_audiobook_player/resources/models/models.dart';

class AuthenticationService {

  User currentUser;

  Future<User> getCurrentUser() async {
    return currentUser;
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    if (email == null || password == null) return null;
    // TODO: validate login
    var user = User(email: email);
    currentUser = user;
    return user;
  }

  Future<void> signOut() async {
    // TODO: sign out
    currentUser = null;
  }

}