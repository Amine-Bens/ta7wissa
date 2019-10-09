import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class crudMethods{
  bool isLoggedIn() {
  if (FirebaseAuth.instance.currentUser()!= null) {
    return true;
  }
  else return false;
  }
getData() async {
    return await Firestore.instance.collection('Places').getDocuments();
}
}