import 'package:fan_project/authentication/auth_user.dart';
import 'package:fan_project/authentication/registration.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/newsProvider.dart';
import '../screens/createNewsScreen.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    // userProvider.setLoggedInUser(FirebaseAuth.instance.currentUser!.email!);
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                  ),
                  Text(
                    userProvider.loggedInUser?.username ?? 'Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.white),
              title: Text(
                'Account Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Add your functionality for account settings here
              },
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings,  color: Colors.white),
              title: Text(
                'Admin Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Add your functionality for admin settings here
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded,  color: Colors.white),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                authInstance?.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

