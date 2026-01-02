import 'package:e_commerce_app_session_it_sharks/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../features/branches/presentation/pages/branches_page.dart';
import '../../features/home/presentation/pages/search_page.dart';
import '../styles/app_colors.dart';

class BasicLayout extends StatefulWidget {
  const BasicLayout({super.key});

  @override
  State<BasicLayout> createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomePage(),
    BranchesPage(),
    SearchPage(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        selectedItemColor: AppColors.kPrimaryColor,
          unselectedItemColor: Colors.blueGrey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: "Branches"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: "Search"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings"
            ),
          ],
          onTap: (value) => setState(() {
            currentIndex = value;
          }),

      ),
    );
  }
}
