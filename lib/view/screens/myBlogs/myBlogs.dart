import 'package:blog_app/core/firebaseApi.dart';
import 'package:blog_app/view/screens/myBlogs/createBlog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global_resources.dart';

class MyBlogs extends StatelessWidget {
  const MyBlogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Products",
          style: TextStyle(
              color: primary, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "createPostBtn",
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProduct()));
        },
        label: Text('Create Post'),
        icon: Icon(Icons.create_outlined),
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseApi()
                  .firebaseFirestore!
                  .collection('Blogs')
                  .where('id',
                      isEqualTo: FirebaseApi().firebaseAuth!.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else if (snapshot.data!.size == 0) {
                  return Center(
                      child: Text(
                    "Currently you have no Post",
                    style: TextStyle(color: Colors.black),
                  ));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, i) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 6.0,
                                child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data!.docs[i]['images']),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Color.fromRGBO(20, 20, 20, 0.5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data!.docs[i]['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display4!
                                                    .merge(TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              Text(
                                                snapshot.data!.docs[i]['desc'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display4!
                                                    .merge(TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300)),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 1,
                            top: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.blue, // button color
                                    child: InkWell(
                                      child: SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ClipOval(
                                  child: Material(
                                    color: Colors.red, // button color
                                    child: InkWell(
                                      child: SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                            size: 20,
                                          )),
                                      onTap: () =>
                                          deletePost(snapshot.data!.docs[i].id),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              })),
    );
  }

  void deletePost(String id) {
    FirebaseApi().firebaseFirestore!.collection('Blogs').doc(id).delete();
  }
}
