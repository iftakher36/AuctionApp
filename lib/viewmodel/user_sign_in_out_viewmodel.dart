import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/constant.dart';

class UserSignInOutViewModel with ChangeNotifier {
  GoogleSignInAccount? _signInAccount;
  User? currentUser;

  GoogleSignInAccount? get signInAccount => _signInAccount;

  Future signInToGoogleGmail(BuildContext context) async {
    await GoogleSignIn().signIn().then((value) async {
      _signInAccount = value;
      await googleAuthentication(_signInAccount!,context);
    });
  }

  Future googleAuthentication(GoogleSignInAccount googleSignIn,BuildContext context) async {
    await googleSignIn.authentication.then((value) {
      oAuthVerification(value,context);
    });

  }

  ///authenticating to oAuth
  Future oAuthVerification(
      GoogleSignInAuthentication googleSignInAuthentication,BuildContext context) async {
    OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    await registeringUserInFireBase(oAuthCredential,context);
  }

  ///register in firebase
  Future registeringUserInFireBase(OAuthCredential credential,BuildContext context) async {
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) => checkIfCurrentlyAnyOneLogin(context));
  }

  checkIfCurrentlyAnyOneLogin(BuildContext context) {
    currentUser = getCurrentUser();
    if (currentUser != null) {
      Navigator.of(context).popAndPushNamed(Constant.dashBoardPage);
    }
  }

  ///get current registered user
  getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  ///reset data while leaving the page
  resetData() {
    currentUser = null;
    _signInAccount = null;  }

}
