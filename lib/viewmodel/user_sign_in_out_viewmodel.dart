import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/constant.dart';

class UserSignInOutViewModel with ChangeNotifier {
  GoogleSignInAccount? _signInAccount;
  User? currentUser;

  GoogleSignInAccount? get signInAccount => _signInAccount;

  Future signInToGoogleGmail() async {
    await GoogleSignIn().signIn().then((value) async {
      _signInAccount = value;
      await googleAuthentication(_signInAccount!);
    });
  }

  Future googleAuthentication(GoogleSignInAccount googleSignIn) async {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignIn.authentication;
    oAuthVerification(googleSignInAuthentication);
  }

  ///authenticating to oAuth
  Future oAuthVerification(
      GoogleSignInAuthentication googleSignInAuthentication) async {
    OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    registeringUserInFireBase(oAuthCredential);
  }

  ///register in firebase
  Future registeringUserInFireBase(OAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  checkIfCurrentlyAnyOneLogin(BuildContext context) {
    currentUser = getCurrentUser();
    if (currentUser != null) {
      Navigator.of(context).pushNamed(Constant.dashBoardPage);
    }
  }

  ///get current registered user
  getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  ///reset the data
  resetData() {
    currentUser = null;
    _signInAccount = null;
  }
}
