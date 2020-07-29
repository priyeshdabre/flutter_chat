import 'package:chat_app/constants.dart';
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

  void createChatroom(String currentUser, String user2) {
    try {
      _firestore
          .collection('chatrooms')
          .document(currentUser.compareTo(user2) == 0
              ? '${currentUser}_$user2'
              : currentUser.compareTo(user2) == 1
                  ? '${currentUser}_$user2'
                  : '${user2}_$currentUser')
          .setData({
        'chatroomId': currentUser.compareTo(user2) == 0
            ? '${currentUser}_$user2'
            : currentUser.compareTo(user2) == 1
                ? '${currentUser}_$user2'
                : '${user2}_$currentUser',
        'users': [user2, currentUser]
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void addChats(String currentUser, String user2, String message) {
    _firestore
        .collection('chatrooms')
        .document(currentUser.compareTo(user2) == 0
            ? '${currentUser}_$user2'
            : currentUser.compareTo(user2) == 1
                ? '${currentUser}_$user2'
                : '${user2}_$currentUser')
        .collection('chats')
        .add({
      'message': message,
      'sentBy': currentUser,
      'timestamp': DateTime.now()
    });
  }

  Stream<QuerySnapshot> getChats(String currentUser, String user2) {
    return _firestore
        .collection('chatrooms')
        .document(currentUser.compareTo(user2) == 0
            ? '${currentUser}_$user2'
            : currentUser.compareTo(user2) == 1
                ? '${currentUser}_$user2'
                : '${user2}_$currentUser')
        .collection('chats')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getConversations() {
    return _firestore
        .collection('chatrooms')
        .where('users', arrayContains: repository.queries.username)
        .snapshots();
  }
}
