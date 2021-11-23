import 'dart:io';

import 'package:blog_app/core/firebaseApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();

  List<String> category = ['Movies', 'Sports'];

  String selectedCategory = 'Sports';

  bool _loader = false;

  late File image;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Blog"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    "Name",
                    style: TextStyle(
                        color: Theme.of(context).hintColor, fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (input) {
                    if (input!.isEmpty)
                      return "Required Field";
                    else
                      return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16, top: 10),
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: "Enter product name"),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        "Choose Category",
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 20) / 2,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('choose'),
                            value: selectedCategory,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategory = newValue.toString();
                              });
                            },
                            items: category.map((cat) {
                              return DropdownMenuItem<String>(
                                child: new Text(
                                  cat,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                value: cat,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                        color: Theme.of(context).hintColor, fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                TextFormField(
                  controller: descController,
                  validator: (input) {
                    if (input!.isEmpty)
                      return "Required Field";
                    else
                      return null;
                  },
                  maxLines: 10,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16, top: 15),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Colors.grey[300],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: "Enter details about your Product / Services"),
                ),
                SizedBox(height: 15),
                 InkWell(
                  onTap: () async {
                    _getFromGallery();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: Icon(Icons.add_photo_alternate_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                !_loader
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xff7D2C91),
                                    Colors.deepPurple,
                                  ],
                                ),
                              ),
                              child: Text(
                                "Post",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              uploadBlog();
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadBlog() async {
    await FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg')
        .putFile(image)
        .then((taskSnapshot) {
      print("task done");
      taskSnapshot.ref.getDownloadURL().then((value) async {
        await FirebaseApi().firebaseFirestore!.collection('Blogs').add({
          'id': FirebaseApi().firebaseAuth!.currentUser!.uid,
          'title': titleController.text,
          'desc': descController.text,
          'category': selectedCategory,
          'images': value,
        }).then((DocumentReference value) {
          Navigator.pop(context);
        });
      });
    });
  }
}
