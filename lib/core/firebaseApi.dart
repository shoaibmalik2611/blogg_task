import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  FirebaseAuth? firebaseAuth;
  FirebaseFirestore? firebaseFirestore;

  FirebaseApi() {
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
  }
}
