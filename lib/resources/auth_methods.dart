import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/models/users.dart' as model;
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up function
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred with sign up";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //resister user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        print('new user id: ' + cred.user!.uid);
        //add user to database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email' : email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      } else if (err.code == 'email-already-in-use') {
        res = 'Email is already used by another account';
      }
      //add the other error codes for password, bio, etc.
    } catch (err) {
      res = err.toString();
    }
    print(res);
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred with login";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please fill in required fields";
      }
    }
    //specific error messages
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'User not found';
      } else if (e.code == 'wrong-password') {
        res = 'Invalid password';
      } else if (e.code == 'too-many-requests') {
        res =
            'This account has been temporarily locked due to too many login attempts';
      } else if (e.code == 'invalid-credential') {
        res = 'Incorrect password';
      }
    } catch (err) {
      res = err.toString();
      print(res);
    }

    return res;
  }
}
