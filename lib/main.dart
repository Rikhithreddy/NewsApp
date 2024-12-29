import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'classes.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedindex=0;
  dynamic pages=[HomePage(),MySearchDelegate(),SavedPage()];
  void _ontappeditem(index){
      setState(() {
        _selectedindex=index;
      });
    
  }
  void _leadingiconfunctions(int _selectedindex){
    switch(_selectedindex){
      case 0: showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Confirm Exit?'),
                        content: Text('Are you sure want to exit'),
                        actions: [
                          TextButton(
                            child: Text('NO'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text('YES'),
                            onPressed: (){
                              Navigator.of(context).pop();
                              SystemNavigator.pop();
                            },
                          ),
                        ],
                      );
                    }
                  );
      case 1: Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
      case 2: Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: (){
                  _leadingiconfunctions(_selectedindex);
                },
              );
            }
          ),
          backgroundColor: const Color.fromARGB(255, 229, 236, 98),
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
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>profilePage()),
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
