import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_project/models/customUser.dart';
import 'package:flutter/material.dart';

createUser(CustomUser user) async {
  Map<String, dynamic> userMap = user.toMap();
  bool userExists = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.userId)
      .get()
      .then((value) {
    if (value.exists)
      return true;
    else
      return false;
  });
  if (userExists == false) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.userId)
        .set(userMap);
  }

  // Registration successful
  print("Registration successful");
}
