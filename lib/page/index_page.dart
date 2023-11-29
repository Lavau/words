import 'package:flutter/material.dart';

import 'home_page.dart';
import 'error_page.dart';
import 'info_page.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      label: "首页",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: "错题本"
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.favorite),
    //   label: "收藏"
    // ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "个人中心"
    ),
  ];

  late int currentIndex;
  final pages = [const HomePage(), const ErrorPage(), const InfoPage()];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _changePage(index);
          },
        ),
        body: pages[currentIndex]
    );
  }

  void _changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}