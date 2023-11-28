import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelly SIMONZ Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleColor = Color.fromRGBO(238, 147, 34, 1.0);
    final lineColor = Color.fromRGBO(238, 147, 34, 1.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/images/ROGO.png', // Replace with the actual path to your image
          height: 40, // Adjust the height as needed
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/kelly-2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelly',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: lineColor,
                            fontFamily: 'Rockout',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Simonz',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: lineColor,
                            fontFamily: 'Rockout',
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 1,
                          width: 330,
                          color: lineColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Early Career and Major Debut',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                          fontFamily: 'Rockout',
                        ),
                        textAlign: TextAlign.center, // Center-align the text
                      ),
                    ),
                    SizedBox(height: 8),
                    Image.asset(
                      'assets/images/kelly-3.jpg',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '''
          Commenced guitar journey at 14, opening for Loudness at 17. Post high school, enrolled at MI in Hollywood. Active in bands and sessions while in school. Self-produced "Sign Of The Times" released in 1998, major debut with "Silent Scream" the following year.
          ''',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center, // Center-align the text
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'International Recognition and Teaching Career',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                          fontFamily: 'Rockout',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '''
            In 2002, released "The Rule Of Right" as Kelly SIMONZ's BLIND FAITH, signing a global deal with Finland's LION MUSIC. Toured Europe with the "Hughes Turner Project" in 2002. Appointed special lecturer at ESP/MI Japan since 2003 and NCA (now NSM) since 2005. Published influential teaching materials with Rittor Music in 2009.
                                ''',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/kelly-1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Ventures',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                          fontFamily: 'Rockout',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8),
                    SectionWithIcon(
                      icon: Icons.music_note,
                      content: '''
Parallel to solo work, initiated Kelly SIMONZ's bAd TRIBE and Kelly SIMONZ's BLIND FAITH in 2012. Demonstrated at global music fairs in 2013. Released "BLIND FAITH" in 2014, followed by "HOLY WINTER" in November. Continued band activities, including Taiwan expedition in 2015 and first Korean expedition in 2016.
                  ''',
                    ),
                    SizedBox(height: 16),
                    SectionWithIcon(
                      icon: Icons.music_note,
                      content: '''
Formed "The Exthunders" in 2018, hosting unique events. In 2019, toured Japan with Yngwie Malmsteen's Mark Boals. In 2020, launched a project with Boals, aiming for global recognition and expansion.
                  ''',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Main Works and Appearances',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                          fontFamily: 'Rockout',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8),
                    SectionWithTitle(
                      title: 'Books',
                      content: '''
- Transcendental guitarist training cast
- Transcendental guitarist training cast "Lonely Classic Masterpieces"
- Transcendental guitarist training cast "Tenka Musou no Kyosoku DVD Edition"
- A book that allows you to play the sound you imagined with your head on the guitar
- A book that you can play the crying guitar that you imagined with your head
          ''',
                    ),
                    SizedBox(height: 8),
                    SectionWithTitle(
                      title: 'Television',
                      content: '''
- E tele "Musica Pikko Reno" - heavy and fast ~ ed.
- E-tele "Lalala ♪ Classic" ~ Metal loves Classic?

          ''',
                    ),
                    SizedBox(height: 8),
                    SectionWithTitle(
                      title: 'Web',
                      content: '''
- Transcendental Champion Kelly SIMONZ Long Interview
(1) The difference between the Japanese music business and Europe and the United States, which the solitary guitarist Kelly SIMONZ talks about "transcendence"
(2) The difference between the Japanese music business and Europe and the United States, which the solitary guitarist Kelly SIMONZ talks about "transcendence" (Part 2)

          ''',
                    ),
                    SizedBox(height: 8),
                    SectionWithTitle(
                      title: 'Event',
                      content: '''
- Musical Instrument Fair 2011 (Rittor Music, Marshall (YMJ) Demonstration)
- TOKYO GUITAR SHOW 2012 (Guild Acoustic Demonstration)
- NAMM 2013 (FGN demonstration)
- Music CHINA 2013 (FGN demonstration)
- TOKYO GUITAR SHOW 2014 (Fender Custom Shop Demonstration)
- Musical Instrument Fair 2014 (Marshall (YMJ) Live Stage)
- Olympus x Fender Contest (Special demonstration)
- Musical Instrument Fair 2016 (Marshall "CODE" demonstration)
- Setagaya Band Battle in NHK Giken! (Judge & Demonstration)
- Gakunan Electric Railway "Metal Train" (Live performance on a moving train)
- Suruga Bay Ferry "Ferry Christmas on board" (Live demonstration on board regular flights)
- 2018 Musical Instrument Fair (Exhibition with original booster and amplifier)

          ''',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionWithIcon extends StatelessWidget {
  final IconData icon;
  final String? title; // Make the title optional
  final String content;

  SectionWithIcon({
    required this.icon,
    this.title, // Make the title optional
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = Color.fromRGBO(238, 147, 34, 1.0);
    final boxColor = titleColor.withOpacity(0.2); // Background color with opacity

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: boxColor, // Set the background color here
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: titleColor,
                  size: 30,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) // Display the title only if it's not null
                        Text(
                          title!,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                            fontFamily: 'Rockout',
                          ),
                        ),
                      if (title != null) SizedBox(height: 8), // Add spacing if title is present
                      Text(
                        content,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionWithTitle extends StatelessWidget {
  final String title;
  final String content;

  SectionWithTitle({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final titleColor = Color.fromRGBO(238, 147, 34, 1.0);

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                  fontFamily: 'Rockout',
                ),
              ),
            ),
            Divider(
              color: titleColor,
              indent: 110,
              endIndent: 110,
              height: 5, // Adjusted divider height
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
