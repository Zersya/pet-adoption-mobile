import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _user;
  FirebaseUser get user => _user;

  void checkUser() async {
    _user = await _auth.currentUser();
    notifyListeners();
  }

  Future handleSignInGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    _user = await _auth.signInWithCredential(credential);
    notifyListeners();
  }

  Future handleSignInFacebook() async {
    final result = await _facebookLogin.logInWithReadPermissions(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );

    _user = await _auth.signInWithCredential(credential);
    notifyListeners();
  }

  void handleSignOut() async {
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    }
    if (await _facebookLogin.isLoggedIn != null) await _facebookLogin.logOut();

    await _auth.signOut();

    _user = null;
    notifyListeners();
  }
}
