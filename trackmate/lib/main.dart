import 'package:flutter/material.dart';
import 'package:trackmate/screens/attendance.dart';
import 'package:trackmate/screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyProfilePage(),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  int currentPageIndex = 0;

  void onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onDestinationSelected: onDestinationSelected,
        selectedIndex: currentPageIndex,
      ),
      body: <Widget>[
        Home(),
        Attendance(),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
      ][currentPageIndex],
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final void Function(int) onDestinationSelected;
  final int selectedIndex;

  const CustomBottomNavigationBar({
    required this.onDestinationSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true, // Show labels for selected items
      selectedItemColor: Colors.black87,
      showUnselectedLabels: true, // Show labels for unselected items
      type: BottomNavigationBarType.fixed,
      onTap: onDestinationSelected,
      currentIndex: selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home), // Change the icon when selected
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          activeIcon: Icon(Icons.article), // Change the icon when selected
          label: 'Attendance',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.equalizer_outlined),
          activeIcon: Icon(Icons.equalizer), // Change the icon when selected
          label: 'Stats',
        ),
      ],
    );
  }
}
