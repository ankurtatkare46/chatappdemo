import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier{
  //instance of Auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign user in
Future<UserCredential> signWithEmailandPassword(String email,String password) async{
  try{
    //signin
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);


    //add a new document for the user collection if it does not already exists
    _firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid' : userCredential.user!.uid,
      // 'email': userCredential.user!.email;
      'email': email,

    },SetOptions(merge: true));

    return userCredential;
  }//catch any error
  on FirebaseAuthException catch (e){
    throw Exception(e.code.toString());
  }
}



//Create a new user
  Future<UserCredential> signUpWithEmailandPassword(String email,String password) async{
  try{
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    //after creating the user , create a new document for the user in the users collection

    _firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid' : userCredential.user!.uid,
      // 'email': userCredential.user!.email;
      'email': email,

    });

    return userCredential;
  }
  on FirebaseAuthException catch(e){
    throw Exception(e.code.toString());
  }
  }


//sign user out
Future<void> signOut() async{
  return await FirebaseAuth.instance.signOut();
}
}