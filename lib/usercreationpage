import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ProfileDetails());
}

class ProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Details'),
          backgroundColor: Color(0xFF2C142E),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black,Color(0xFFbd378e) ], // Define your gradient colors here
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ProfileForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String _userName = '';
  String _email = '';
  String _password = '';
  String _region = '';
  String _selectedImage = 'assets/download.jpeg';

  Future<void> _selectProfileImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _selectedImage = pickedFile.path);
  }

  Widget _buildTextField(String label, bool obscureText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xFF2C142E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            if (label == 'Username') _userName = value;
            if (label == 'Email Address') _email = value;
            if (label == 'Password') _password = value;
            if (label == 'Region') _region = value;
          });
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _selectProfileImage,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFF2C142E),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 58,
                  backgroundImage: AssetImage(_selectedImage),
                  backgroundColor: Color(0xFF2C142E),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildTextField('Username', false),
          _buildTextField('Email Address', false),
          _buildTextField('Password', true),
          _buildTextField('Region', false),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Username: $_userName');
              print('Email: $_email');
              print('Password: $_password');
              print('Region: $_region');
            },
            style: ElevatedButton.styleFrom(
              primary:Color(0xFF2C142E) ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(
              'Save Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
