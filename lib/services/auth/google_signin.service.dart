import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/core/utils/app_logger.dart';

class GoogleSigninService {
  final googleSignIn = GoogleSignIn();

  Future<bool> signIn() async {
    try {
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      AppLogger.printLog(e);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      AppLogger.printLog(e);
      return false;
    }
  }
}
