import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();
  bool _showBottomBar = true;
  int _currentPage = 0;
  Timer? _scrollTimer;
  double _previousScrollOffset = 0.0;
  double _appBarOpacity = 0.0;
  var pages = [0,1,2,3,4,5,6,7] ;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    _scrollController.addListener(() {
      setState(() {
        _appBarOpacity = _scrollController.offset > 150 ? 1.0 : _scrollController.offset / 150;
      });
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _toggleBottomBarVisibility(true);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _toggleBottomBarVisibility(false);
      }
      if (_scrollTimer != null && _scrollTimer!.isActive) {
        // If the timer is active, cancel it (user is still scrolling)
        _scrollTimer!.cancel();
      }
      // Start a new timer when scrolling stops
      _scrollTimer = Timer(Duration(milliseconds: 150), () {
        if(_scrollController.position.pixels - _previousScrollOffset >= 50 || _previousScrollOffset - _scrollController.position.pixels >= 50  ) {
          print("scrolled") ;
        }
        setState(() {
          // Update _previousScrollOffset once scrolling stops
          _previousScrollOffset = _scrollController.position.pixels;
          print("Scroll Ended. Previous Offset: $_previousScrollOffset");
        });
      });
    });
  }

  void _toggleBottomBarVisibility(bool isVisible) {
    setState(() {
      _showBottomBar = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            onSwipeRight();
          } else if (details.primaryVelocity! < 0) {
            // Swiped to the left
            onSwipeLeft();
          }
        }, child: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return buildPage(index);
        },
      ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        height: _showBottomBar ? 50.0 : 0.0,
        child: Visibility(
          visible: _showBottomBar,
          child: BottomAppBar(
            child: Container(
              height: 50.0,
              child: const Center(
                child: Text('Bottom Bar Content'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPage(int index) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.black.withOpacity(_appBarOpacity),
        title: Text('Page $index'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/male_avtar_white.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Demo Data for Page $_currentPage',
                    style: const TextStyle(fontSize: 24.0, color: Colors.black),
                  ),
                  const SizedBox(height: 16.0),
                  // Add more demo data widgets below
                  const Text(
                    'Additional Data 1',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  const Text(
                    'Additional Data 2',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    'Demo Data for Page $_currentPage',
                    style: const TextStyle(fontSize: 24.0, color: Colors.black),
                  ),
                  const SizedBox(height: 16.0),
                  // Add more demo data widgets below
                  const Text(
                    'Additional Data 1',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  const Text(
                    'Additional Data 2',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    'Demo Data for Page $_currentPage',
                    style: const TextStyle(fontSize: 24.0, color: Colors.black),
                  ),
                  const SizedBox(height: 16.0),
                  // Add more demo data widgets below
                  const Text(
                    'Additional Data 1',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  const Text(
                    'Additional Data 2',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  // Dummy data below the image
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  const SizedBox(height: 20),
                  const Text('Donec auctor interdum sapien, eu ullamcorper lacus laoreet non.'),
                  const SizedBox(height: 20),
                  // Dummy data below the image
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  const SizedBox(height: 20),
                  const Text('Donec auctor interdum sapien, eu ullamcorper lacus laoreet non.'),
                  const SizedBox(height: 20),
                  // Dummy data below the image
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  const SizedBox(height: 20),
                  const Text('Donec auctor interdum sapien, eu ullamcorper lacus laoreet non.'),
                  const SizedBox(height: 20),
                  // Dummy data below the image
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  const SizedBox(height: 20),
                  const Text('Donec auctor interdum sapien, eu ullamcorper lacus laoreet non.'),
                  const SizedBox(height: 20),
                  // Dummy data below the image
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  const SizedBox(height: 20),
                  const Text('Donec auctor interdum sapien, eu ullamcorper lacus laoreet non.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSwipeLeft() {
    setState(() {
      if(_currentPage < pages.length - 1) {
        _currentPage++;
      }else{
        _currentPage = 0 ;
      }
      _pageController.jumpToPage(_currentPage) ;
    });
    if (kDebugMode) {
      print('Swiped to the left');
    }
  }

  void onSwipeRight() {
    setState(() {
      if(_currentPage < pages.length - 1) {
        _currentPage++;
      }else{
        _currentPage = 0 ;
      }
      _pageController.jumpToPage(_currentPage) ;
    });
    if (kDebugMode) {
      print('Swiped to the right');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}