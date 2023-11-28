import 'package:fan_project/screens/estoreHome.dart';
import 'package:fan_project/screens/homeScreen.dart';
import 'package:fan_project/screens/profileScreen.dart';
import 'package:fan_project/sharedWidgets/tempSidebar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.orange,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.live_tv, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.white),
          label: '',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductListingPage()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
            break;
          default:
            break;
        }
      },
    );
  }
}