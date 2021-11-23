import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'firebaseApi.dart';

class FirebaseManager {
  signIn(String mail, String pass) async {
    return FirebaseApi()
        .firebaseAuth!
        .signInWithEmailAndPassword(email: mail.trim(), password: pass.trim())
        .then((value) => value);
  }

  getSpecificCategoryBlog(String category) {
    return FirebaseApi()
        .firebaseFirestore!
        .collection('Blogs')
        .where('category', isEqualTo: category)
        .snapshots();
  }

  Future<String> uploadProductImage(File imageFile) async {
    try {
      final uploadTask = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg')
          .putFile(imageFile);
      return await uploadTask.snapshot.ref.getDownloadURL();
    } on PlatformException catch (err) {
      print(err);
      return '';
    } catch (e) {
      print(e);
      return '';
    }
  }
}
