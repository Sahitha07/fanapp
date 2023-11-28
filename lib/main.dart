import 'package:fan_project/authentication/checkLoggedIn.dart';
import 'package:fan_project/authentication/login.dart';
import 'package:fan_project/providers/eventsProvider.dart';
import 'package:fan_project/providers/newsProvider.dart';
import 'package:fan_project/screens//homeScreen.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'authentication/registration.dart';
import 'firebase_options.dart';
import 'authentication/auth_user.dart';
import 'mediaStorage/videoCache.dart';
import 'temp.dart';
import 'facebookModule/fetchFacebookData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  UserProvider userProvider = UserProvider();
  late NewsProvider newsProvider;
  late EventsProvider eventsProvider;

  @override
  Widget build(BuildContext context) {
    clearAllVideoCache();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) {
          userProvider.getAllUsersStream();
          if (authUser != null) userProvider.setLoggedInUser(authUser!.email!);
          return userProvider;
        }),
        ChangeNotifierProvider<EventsProvider>(create: (context) {
          print("Events provider create try");
          eventsProvider = EventsProvider(userProvider: userProvider);

          return eventsProvider;
        }),
        ChangeNotifierProvider<NewsProvider>(create: (context) {
          newsProvider = NewsProvider(userProvider: userProvider);
          // newsProvider.getAllNewsStream(userProvider: userProvider);

          return newsProvider;
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CheckLoggedIn(),
        // home: VideoPlayerScreen(
        //   videoController: controller,
        // ),
      ),
    );
  }
}
