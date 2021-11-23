import 'package:blog_app/view/screens/home/moviesBlog.dart';
import 'package:blog_app/view/screens/home/sportsBlog.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade500,
          title: Text('Home'),
          bottom: TabBar(
            indicatorColor: Colors.lime,
            indicatorWeight: 5.0,
            labelColor: Colors.white,
            labelPadding: EdgeInsets.only(top: 10.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Movies',
              ),
              Tab(
                text: 'Sports',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [MoviesBlog(), SportsBlog()],
        ),
      ),
    );
  }
}
