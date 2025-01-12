import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/loginpage.dart';
import 'package:newsapp/profilepage.dart';
import 'package:newsapp/savedpage.dart';
import 'package:newsapp/serachpage.dart';
import 'homepage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: loginpage(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedindex = 0;
  dynamic pages = [Homepage(), MySearchDelegate(), SavedPage()];
  void _ontappeditem(index) {
    setState(() {
      _selectedindex = index;
    });
  }

  void _leadingiconfunctions(int selectedindex) {
    switch (selectedindex) {
      case 0:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirm Exit?'),
                content: Text('Are you sure want to exit'),
                actions: [
                  TextButton(
                    child: Text('NO'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('YES'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      SystemNavigator.pop();
                    },
                  ),
                ],
              );
            });
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _leadingiconfunctions(_selectedindex);
            },
          );
        }),
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            'NewsApp',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>profilepage()),
              );
            },
          ),
        ],
      ),
      body: pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _ontappeditem,
        backgroundColor: const Color.fromARGB(255, 207, 181, 104),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 38, 33, 33),
        currentIndex: _selectedindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
