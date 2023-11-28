import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/adminConsole.dart';
import 'package:fan_project/screens/createNewsScreen.dart';
import 'package:flutter/material.dart';
import 'package:fan_project/authentication/auth_user.dart';
import 'package:fan_project/authentication/registration.dart';
import 'package:flutter_svg/svg.dart';

class NavAppBar extends StatefulWidget implements PreferredSizeWidget {
  NavAppBar({super.key, this.title});
  String? title;

  @override
  State<NavAppBar> createState() => _NavAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _NavAppBarState extends State<NavAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            'assets/images/ROGO.png',
            width: 130,
            height: 100,
          ),
          SizedBox(width: 20),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.admin_panel_settings),
          color: Colors.orange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          color: Colors.orange,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.orange,
          onPressed: () {
            authInstance?.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
          },
        )
      ],
      backgroundColor: Colors.black,
      bottom: TabBar(
        labelColor: Colors.orange,
        unselectedLabelColor: Colors.white,
        indicatorColor: Colors.orange,
        tabs: [
          Tab(
            text: 'News',
          ),
          Tab(
            text: 'Events',
          ),
          Tab(
            text: 'Gallery',
          ),
        ],
      ),
      iconTheme: IconThemeData(color: Colors.orange), // Set back arrow color
    );
  }
}