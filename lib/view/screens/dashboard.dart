import 'package:blog_app/view/screens/home/allBlogs.dart';
import 'package:blog_app/view/screens/myBlogs/myBlogs.dart';
import 'package:flutter/material.dart';

import '../../global_resources.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;
  PageController tabController = PageController();

  changeTab(int tabIndex) {
    setState(() {
      currentTab = tabIndex;
    });
    tabController.jumpToPage(
      tabIndex,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (tabController.page == 0) {
          return true;
        } else {
          changeTab(0);
          return false;
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey[800],
          showUnselectedLabels: true,
          currentIndex: currentTab,
          onTap: changeTab,
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits),
                label: 'My Blogs'),
          ],
        ),
        body: Center(
          child: PageView(
            controller: tabController,
            onPageChanged: (int tabIndex) {
              if (tabIndex != currentTab) {
                setState(() {
                  currentTab = tabIndex;
                });
              }
            },
            children: [
              Home(),
              MyBlogs(),
            ],
          ),
        ),
      ),
    );
  }
}
