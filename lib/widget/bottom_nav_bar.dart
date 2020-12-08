import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/view/findFriendView.dart';
import 'package:foody_app/view/foodSuggestion.dart';
import 'package:foody_app/view/homeView.dart';
import 'package:foody_app/view/meetAndEatView.dart';
import 'package:foody_app/view/profileView.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final _viewOptions = [
    HomeView(),
    FindFriendView(),
    MeetAndEatView(),
    FoodSuggestionView(),
    ProfileView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _viewOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search),
            label: 'Friend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined),
            label: 'Meet & Eat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            label: 'Suggestion',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.PRIMARY_COLOR,
        unselectedItemColor: Colors.grey[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
