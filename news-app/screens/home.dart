import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app_demo/screens/details_screen.dart';
import 'package:news_app_demo/screens/splash_screen.dart';

import '../models/article.dart';
import '../models/destination.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.nextWebArticles,
      required this.associatedPressArticles,
      required this.isOnline});

  final String title;
  final List<Article> nextWebArticles;
  final List<Article> associatedPressArticles;
  final bool isOnline;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Article> resultList = [];
  late List<Widget> screens = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = 0;

  @override
  void initState() {
    setState(() {
      resultList = widget.nextWebArticles + widget.associatedPressArticles;
      screens = [
        getExplore(),
        getLiveChat(),
        getGallery(),
        getWishList(),
        getMagazine()
      ];
    });
  }

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      backgroundColor: const Color.fromRGBO(36, 55, 172, 1),
      behavior: SnackBarBehavior.floating,
      content: Text(
        destinations[screenIndex].label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    ));
    Timer(const Duration(milliseconds: 750), () {
      Navigator.of(context).pop();
    });
  }

  Widget getExplore() {
    return ListView.builder(
      itemCount: resultList.length,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return InkResponse(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailsScreen(resultList[position]);
              },
            ));
          },
          child: Card(
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
                Image.network(
                  resultList[position].urlToImage,
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
                  margin:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resultList[position].title,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Text(
                            ' By ${resultList[position].author.split(',').first}',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(resultList[position].publishedAt.split('T').first,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300)),
                      ],
                    )),
                //ListTile(leading: Text("dsada"),title: Text("dsada"),trailing: Text("asdassda"),)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getLiveChat() {
    return const Text('Live Chat',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget getGallery() {
    return const Text('Gallery',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget getWishList() {
    return const Text('Wish List',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget getMagazine() {
    return const Text('E-Magazine',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget getOffline() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No Internet Connection ',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SplashScreen();
                  },
                ));
              },
              child: const Row(
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  Text(
                    "Reload",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget getNoData() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('There Is A Problem, No Data',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SplashScreen();
                  },
                ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  Text(
                    "Reload",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget getSideMenu() {
    return Drawer(
      child: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        indicatorColor: Colors.black,
        backgroundColor: Colors.white,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/icon-user.png'),
                  backgroundColor: Colors.white,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        )),
                    Text('User Name')
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_forward_ios))
              ],
            ),
          ),
          ...destinations.map(
            (LinkDestination destination) {
              return NavigationDrawerDestination(
                label: Text(
                  destination.label,
                  style: TextStyle(
                    color: destinations.indexOf(destination) == screenIndex
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: 250,
        child: getSideMenu(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.black,
        elevation: 8.0,
        leading: IconButton(
            onPressed: () {
              if (_scaffoldKey.currentState!.isDrawerOpen) {
                Navigator.pop(context);
              } else {
                _scaffoldKey.currentState!.openDrawer();
              }
            },
            icon: const Icon(Icons.menu)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        title: Text(widget.title),
      ),
      body: Center(
        child: !widget.isOnline
            ? getOffline()
            : resultList.isEmpty
                ? getNoData()
                : screens[screenIndex],
      ),
    );
  }
}
