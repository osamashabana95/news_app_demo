import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app_demo/services.dart';

import '../models/article.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<Article> nextWebArticles;
  late List<Article> associatedPressArticles;
  late bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 55, 172, 1),
      body: Center(
        child: splashScreenIcon(),
      ),
    );
  }

  Widget splashScreenIcon() {
    String iconPath = "assets/animated_logo.gif";

    return Image.asset(
      iconPath,
      width: 200,
    );
  }

  void checkOnline() async {
    //isOnline =
    await InternetConnectionChecker().hasConnection.then((isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        content: Text(
          isOnline
              ? "Good, You have intenet connection"
              : "No Internet, Check Your Intenet Connection",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ));
      isOnline
          ? fetchArticles({
              'source': 'the-next-web',
              'apiKey': '533af958594143758318137469b41ba9'
            }).then((value) {
              setState(() {
                nextWebArticles = value;
              });

              fetchArticles({
                'source': 'associated-press',
                'apiKey': '533af958594143758318137469b41ba9'
              }).then((value) {
                setState(() {
                  associatedPressArticles = value;
                });
                Future.delayed(
                  Duration(seconds: 2),
                  () {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MyHomePage(
                          title: "Link Development",
                          nextWebArticles: nextWebArticles,
                          associatedPressArticles: associatedPressArticles,
                          isOnline: isOnline,
                        );
                      },
                    ));
                  },
                );
              });
            })
          : Future.delayed(
              Duration(seconds: 2),
              () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MyHomePage(
                        title: "Link Development",
                        nextWebArticles: [],
                        associatedPressArticles: [],
                        isOnline: isOnline);
                  },
                ));
              },
            );
      return true;
    });
  }

  @override
  void initState() {
    super.initState();
    checkOnline();
  }
}
