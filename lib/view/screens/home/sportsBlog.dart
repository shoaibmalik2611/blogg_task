import 'package:blog_app/core/firebaseApi.dart';
import 'package:blog_app/core/firebaseManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SportsBlog extends StatelessWidget {
  const SportsBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseManager().getSpecificCategoryBlog('Sports'),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else if (snapshot.data!.size == 0) {
                  return Center(
                      child: Text(
                    "Nothing Here",
                    style: TextStyle(color: Colors.black),
                  ));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(20, 20, 20, 0.5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data!.docs[i]['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .display4!
                                              .merge(TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        Text(
                                          snapshot.data!.docs[i]['desc'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .display4!
                                              .merge(TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }
}
