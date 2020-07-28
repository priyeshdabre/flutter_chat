import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RemoteApis {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  Future<FirebaseUser> login({String email, String password}) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return throw Exception(e);
    }
  }

  Future<FirebaseUser> register({String email, String password}) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return throw Exception(e);
    }
  }

  Future<FirebaseUser> signInwithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = new GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      AuthResult result = await _firebaseAuth.signInWithCredential(credential);
      FirebaseUser userDetails = result.user;
      return userDetails;
    } catch (e) {
      print(e.toString());
      return throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return throw Exception(e);
    }
  }

  Future<void> uploadUserData(String email, String username) async {
    try {
      await _firestore
          .collection('users')
          .document(email)
          .setData({'email': email, 'username': username});
    } catch (e) {
      print(e.toString());
      return throw Exception(e);
    }
  }

  Future<QuerySnapshot> getUserList() async {
    var data;
    try {
      data = await _firestore
          .collection('users')
          .getDocuments(source: Source.server);
      return data;
    } catch (e) {
      print(e.toString());
      return throw Exception(e);
    }
  }

  bool checkIfUserExist(String email) {
    try {
      return _firestore.collection('users').document(email).documentID != null;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }
}
