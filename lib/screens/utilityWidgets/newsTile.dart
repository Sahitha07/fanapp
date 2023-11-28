import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/news.dart';
import '../../providers/newsProvider.dart';

class NewsTile extends StatelessWidget {
  NewsTile({Key? key, required this.news}) : super(key: key);

  final News news;

  Widget _buildLogo() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: news.newsCreatedPlatform == NewsCreatedPlatform.native
          ? Center(
              child: SvgPicture.asset(
                'assets/images/Fan_Logo.svg',
                color: Colors.white,
                semanticsLabel: 'App Logo',
                width: 70,
                height: 70,
              ),
            )
          : Image.network(
              'https://companieslogo.com/img/orig/META-4767da84.png?t=1654568366',
              width: 24,
              height: 24,
            ),
    );
  }

  // If the news is created within the app, display a different logo

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLogo(), // Place the logo in the leading position
      title: Text(
        news.title,
        style: TextStyle(color: Colors.white),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: RichText(
          text: TextSpan(
              style:
                  TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              children: <TextSpan>[
                TextSpan(text: news.description),
              ]),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
