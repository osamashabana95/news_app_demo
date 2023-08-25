import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:news_app_demo/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.black,
        elevation: 8.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Link Development'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Card(
                surfaceTintColor: Colors.white,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.network(
                          article.urlToImage,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Image.asset(
                                'assets/placeholder.png',
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/placeholder.png');
                          },
                        ),
                        Container(
                          color: Colors.black12,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4.0),
                          child: Text(article.publishedAt.split('T').first,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                              height: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                ' By ${article.author.split(',').first}',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300)),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(article.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _launchUrl(context),
                  child: const Text(
                    "OPEN WEBSITE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context) async {
    bool isOnline = await InternetConnectionChecker().hasConnection;
    if (isOnline) {
      if (await canLaunchUrl(Uri.parse(article.url))) {
        if (!await launchUrl(Uri.parse(article.url))) {
          throw Exception('Could not launch ${article.url}');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(36, 55, 172, 1),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "URL Error",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ));
        throw 'Could not launch ';
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromRGBO(36, 55, 172, 1),
        behavior: SnackBarBehavior.floating,
        content: Text(
          "No Internet, Check Your Intenet Connection",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
  }
}
