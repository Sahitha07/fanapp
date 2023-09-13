import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.dosisTextTheme(Theme.of(context).textTheme).copyWith(
          // Apply "Dosis" with thin 100 weight to the entire app
          bodyText1: TextStyle(fontWeight: FontWeight.w100),
          bodyText2: TextStyle(fontWeight: FontWeight.w100),
        ),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color for the entire login page
      backgroundColor: Color.fromARGB(66, 56, 162, 147), // #4492ab color
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/fan_logo.svg', // Replace with your logo image path
                width: 400.0, // Adjust the size of the logo as needed
                height: 400.0,
              ),
              TextField(
                controller: _usernameController,
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: Colors.white, // Text color
                  ),
                ),
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person, color: Colors.white), // Person icon color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color when focused
                  ),
                  labelStyle: TextStyle(color: Colors.white), // Label text color
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: Colors.white, // Text color
                  ),
                ),
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.white), // Lock icon color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color when focused
                  ),
                  labelStyle: TextStyle(color: Colors.white), // Label text color
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity, // Match the width of the text fields
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login logic here
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    // For demonstration purposes, you can check the login credentials
                    // For a real application, you should connect to a backend server for authentication.
                    if (username == 'your_username' && password == 'your_password') {
                      // Navigate to the next screen or perform actions after successful login.
                      print('Login successful');
                    } else {
                      // Display an error message or show a snackbar for incorrect login.
                      print('Login failed');
                    }
                  },
                  child: Text('LOGIN', style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  )),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFA447A2), // Button background color
                    elevation: 0, // Remove button shadow
                    fixedSize: Size.fromHeight(50.0), // Set button height
                  ),
                ),
              ),
              SizedBox(height: 10.0), // Add some spacing
              Text(
                'Forgot Password?',
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
