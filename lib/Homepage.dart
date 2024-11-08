import 'package:flutter/material.dart';
import 'ProfilePage.dart';
import 'myhome.dart';
import 'myinternship.dart';
import 'package:caproj/NotificationPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const MyInternshipsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 70, 120),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
          SizedBox(),
          Text('ApplyWise', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          Container(
            child:
          IconButton(
          icon: const Icon(Icons.notifications,color: Colors.white,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotifcationList(),));
        },
      ),
          ),
            ],
        )
      ),
      body: _pages[_currentIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'My Internships',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 10, 70, 120),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}