import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey, // Set the background color to gray
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80), // Add top padding
            ClipRect(
              child: Image.asset(
                'assets/profile/bts-logo.png', // Replace with your image path
                width: 150.0,
              ),
            ),
            SizedBox(height: 30),
            ClipRect(
              child: Image.asset(
                'assets/profile/bts_all.jpg', // Replace with your image path
                width: double.infinity,
                fit: BoxFit.cover, // Cover the entire area without cropping
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 400, // Adjust the width as needed
              child: Text(
                'BTS, an acronym of Bangtan Sonyeondan or “Beyond the Scene,” is a Grammy-nominated South Korean group that has been capturing the hearts of millions of fans globally since its debut in June 2013. The members of BTS are RM, Jin, SUGA, j-hope, Jimin, V, and Jung Kook. Gaining recognition for their authentic and self-produced music, top-notch performances, and the way they interact with their fans, BTS has established themselves as “21st-century Pop Icons” breaking countless world records. While imparting a positive influence through activities such as the LOVE MYSELF campaign and the UN ‘Speak Yourself’ speech, the band has mobilized millions of fans across the world (named ARMY), collected four No. 1 songs in a span of 9 months, performed multiple sold-out stadium shows across the world, and been named TIME’s Entertainer of the Year 2020. BTS has been nominated for Best Pop Duo/Group Performance for the 63rd Grammy Awards and recognized with numerous prestigious awards like the Billboard Music Awards, American Music Awards, and MTV Video Music Awards.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dosis( // Apply Google Fonts with "Dosis" font
                  fontSize: 13,
                  fontWeight: FontWeight.w300, // Apply thin (100) weight
                  color: Colors.white, // Font color
                ),
              ),
            ),
            SizedBox(height: 10), // Add a small spacing below the text
            Container(
              width: 120, // Adjust the width as needed
              margin: EdgeInsets.only(top: 5.0), // Add a small margin between "Members" and the content
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 35.0), // Add a small padding to the text
                      child: Text(
                        'Members',
                        style: GoogleFonts.dosis( // Apply Google Fonts with "Dosis" font
                          fontSize: 24,
                          fontWeight: FontWeight.w100,
                          color: Colors.black, // Font color
                        ),
                      ),
                    ),
                    onTap: () {
                      // Add any onTap functionality here
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0), // Add padding below the line
                      child: Container(
                        height: 1.0, // Line thickness set to 5 pixels
                        color: Colors.black, // Line color
                        width: 70.0, // Match the width to the parent
                      ),
                    ),
                    onTap: () {
                      // Add any onTap functionality here
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 5.0, // spacing between columns
                  mainAxisSpacing: 5.0, // spacing between rows
                ),
                itemCount: 14, // You can change this as needed
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Disable scroll for GridView
                itemBuilder: (BuildContext context, int index) {
                  // Define specific images for the boxes
                  switch (index) {
                    case 0:
                      return Image.asset(
                        'assets/profile/profile_suga.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      );
                    case 1:
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0), // Add padding to the text
                              child: Text(
                                'Suga',
                                style: GoogleFonts.dosis( // Apply Google Fonts with "Dosis" font
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,// Font color
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0), // Add padding to the text
                              child: Text(
                                'Birthday',
                                style: GoogleFonts.dosis( // Apply Google Fonts with "Dosis" font
                                  color: Colors.white, // Font color
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0), // Add padding to the text
                              child: Text(
                                '1993/3/9',
                                style: GoogleFonts.dosis( // Apply Google Fonts with "Dosis" font
                                  color: Colors.white, // Font color
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case 2:
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0), // Add padding to the text
                              child: Text(
                                'V',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0), // Add padding to the text
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0), // Add padding to the text
                              child: Text(
                                '1995/12/30',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case 5:
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0), // Add padding to the text
                              child: Text(
                                'J-Hope',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0), // Add padding to the text
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0), // Add padding to the text
                              child: Text(
                                '1994/2/18',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case 6:
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0), // Add padding to the text
                              child: Text(
                                'Jin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0), // Add padding to the text
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0), // Add padding to the text
                              child: Text(
                                '1992/12/4',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case 9:
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0), // Add padding to the text
                              child: Text(
                                'Jung Kook',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0), // Add padding to the text
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0), // Add padding to the text
                              child: Text(
                                '1997/9/1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case 10:
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0), // Add padding to the text
                              child: Text(
                                'RM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0), // Add padding to the text
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0), // Add padding to the text
                              child: Text(
                                '1994/9/12',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case 13:
                      return Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0), // Add padding to the text
                              child: Text(
                                'Jimin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4.0), // Add padding to the text
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2.0), // Add padding to the text
                              child: Text(
                                '1995/10/13',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    case 3:
                      return Image.asset(
                        'assets/profile/profile_v.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      );
                    case 4:
                      return Image.asset(
                        'assets/profile/profile_jh.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      );
                    case 7:
                      return Image.asset(
                        'assets/profile/profile_jin.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      );
                    case 8:
                      return Image.asset(
                        'assets/profile/profile_jk.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      );
                    case 11:
                      return Image.asset(
                        'assets/profile/profile_rm.jpg',
                        width: 150.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      );
                    case 12:
                      return Image.asset(
                        'assets/profile/profile_jm.jpg',
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      );
                    default:
                      return Container(); // Return an empty container for unsupported indexes
                  }
                },
              ),
            ),
            Container(
              width: 300, // Adjust the width as needed
              margin: EdgeInsets.only(top: 5.0), // Add a small margin between "Members" and the content
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 35.0), // Add a small padding to the text
                      child: Text(
                        'Managers and Staff',
                        style: GoogleFonts.dosis( // Apply Google Fonts with "Dosis" font
                          fontSize: 24,
                          fontWeight: FontWeight.w100,
                          color: Colors.black, // Font color
                        ),
                      ),
                    ),
                    onTap: () {
                      // Add any onTap functionality here
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0), // Add padding below the line
                      child: Container(
                        height: 1.0, // Line thickness set to 5 pixels
                        color: Colors.black, // Line color
                        width: 70.0, // Match the width to the parent
                      ),
                    ),
                    onTap: () {
                      // Add any onTap functionality here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
