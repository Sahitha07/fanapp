import 'package:fan_project/authentication/login.dart';
import 'package:fan_project/providers/eventsProvider.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'auth_user.dart';

class CheckLoggedIn extends StatefulWidget {
  CheckLoggedIn({super.key});

  @override
  State<CheckLoggedIn> createState() => _CheckLoggedInState();
}

class _CheckLoggedInState extends State<CheckLoggedIn> {
  String? loggedInUser;
  bool hasCheckedForChangedDependencies = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!hasCheckedForChangedDependencies &&
        FirebaseAuth.instance.currentUser != null) {
      if (!hasCheckedForChangedDependencies &&
          Provider.of<UserProvider>(context).allUsers.isNotEmpty) {
        hasCheckedForChangedDependencies = true;
        print(
            "ALL MY USERSSSSS! ${Provider.of<UserProvider>(context).allUsers}");

        if (mounted) {
          Provider.of<UserProvider>(context).silentlySetLoggedInUser(
              FirebaseAuth.instance.currentUser!.email!);
          await Provider.of<NewsProvider>(context).setUserProvider(
              userProvider: Provider.of<UserProvider>(context),
              isNotifyListener: false);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePageScreen()));
          });
        }
      }
    } else if (!hasCheckedForChangedDependencies &&
        FirebaseAuth.instance.currentUser == null) {
      hasCheckedForChangedDependencies = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: const AlertDialog(
            title: Text("Checking logged in user"),
            content: SizedBox(
                width: 30,
                height: 30,
                child: Center(child: CircularProgressIndicator())),
          ),
        ),
      ),
    );
  }
}
