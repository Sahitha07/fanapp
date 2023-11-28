import 'package:fan_project/authentication/auth_user.dart';
import 'package:fan_project/authentication/registration.dart';
import 'package:fan_project/providers/userProvider.dart';
import 'package:fan_project/screens/createEventScreen.dart';
import 'package:fan_project/screens/createNewsScreen.dart';
import 'package:fan_project/screens/productCreationScreen.dart';
import 'package:fan_project/sharedWidgets/appBar.dart';
import 'package:fan_project/sharedWidgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final List<AdminActions> adminActions = [
      AdminActions(
        name: 'Users Management',
        icon: Icons.group,
        actionId: 'users_mgmt',
      ),
      AdminActions(
        name: 'Create News',
        icon: Icons.newspaper,
        actionId: 'news_mgmt',
      ),
      AdminActions(
        name: 'Create Event',
        icon: Icons.event,
        actionId: 'event',
      ),
      AdminActions(
        name: 'Add Media',
        icon: Icons.photo,
        actionId: 'gallery',
      ),
      AdminActions(
        name: 'Edit e-Store',
        icon: Icons.shopping_cart,
        actionId: 'shop',
      ),
      AdminActions(
        name: 'Edit Biography',
        icon: Icons.info,
        actionId: 'bio',
      ),
      AdminActions(
        name: 'Notifications',
        icon: Icons.add_alert,
        actionId: 'notif',
      ),
      // You can add more menu items here
    ];
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              // Add notification logic
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: () {
              authInstance?.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()),
              );
            },
          ),
        ],
        backgroundColor: Colors.black,

      ),
      bottomNavigationBar: BottomNavBar(),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 140.0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 8.0), // Add some space between the avatar and the text
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.loggedInUser?.username ?? 'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      // Add additional text widgets if needed
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add admin actions list
                  Column(
                    children: List.generate(adminActions.length, (index) {
                      final action = adminActions[index];
                      return AdminActionsWidget(action: action);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminActionsWidget extends StatelessWidget {
  final AdminActions action;

  const AdminActionsWidget({required this.action});

  @override
  Widget build(BuildContext context) {
    // Set default text color
    Color textColor = Colors.black;

    // Conditionally set text color based on actionId
    if (action.actionId == 'users_mgmt' ||
        action.actionId == 'news_mgmt' ||
        action.actionId == 'event_mgmt' ||
        action.actionId == 'instr' ||
        action.actionId == 'dwnld') {
      textColor = Colors.black;
    }

    return ListTile(
      leading: Icon(action.icon, color: textColor), // Set icon color
      title: Text(
        action.name,
        style: TextStyle(color: textColor), // Set text color
      ),
      onTap: () {
        // Add navigation or action logic here
        switch (action.actionId) {
          case 'users_mgmt':

            break;
          case 'news_mgmt':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsCreationScreen()),
            );
            break;
          case 'event_mgmt':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventForm()),
            );
            break;
          case 'instr':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductCreationScreen()),
            );
            break;
          case 'dwnld':

            break;
        // Add cases for other actionIds as needed
        }
      },
    );
  }
}


class AdminActions {
  final String name;
  final IconData icon;
  final String actionId;

  const AdminActions({
    required this.name,
    required this.icon,
    required this.actionId,
  });
}

