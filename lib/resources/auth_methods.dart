import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import '../models/user.dart'as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }



  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  })async{
    String res = "Some error occured";
    try {
      if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file!=null){
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password);

        // ignore: avoid_print

        print(cred.user?.uid);
        
        //getting image url for storage

        String photoUrl = await StorageMethods().uploadImageToStorage(
          'profilePics',
           file,
           false
        );
        //add user to our database
        
        model.User user = model.User(
          email: email, 
          uid: cred.user!.uid, 
          photoUrl: photoUrl, 
          username: username, 
          bio: bio, 
          followers: [], 
          following: [],
          );
        await _firestore.collection('users').doc(cred.user!.uid).set(
           user.toJson(),
        );
        res="Success";
      }
    } catch (err) {
      res= err.toString();
    } 
    // print(res);
    return res;
  }
  Future<String> logInUser({
    required String email,
    required String password,
  })async{
    String res = "Some error occured";
    try {
      if(email.isNotEmpty||password.isNotEmpty){
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password);
        res="Success";
        // ignore: avoid_print
        // print(cred.user?.uid);
      }else{
        res="Some field is empty";
      }
    } catch (err) {
      res= err.toString();
    } 
    // print(res);
    return res;
  }

  Future<void> signOut() async {
   await FirebaseAuth.instance.signOut();
  }
}