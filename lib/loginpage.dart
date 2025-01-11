import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/data.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  var emailidcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    loaduser();
  }

  @override
  Widget build(BuildContext context) {
    return data.loggedinusername != ""
        ? MyApp()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text('LOGIN'),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
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
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ),
            body: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('lib/images/profile.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextField(
                    controller: emailidcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Email id'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: TextField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Password'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    width: 120,
                    child: Center(
                      child: Builder(builder: (context) {
                        return TextButton(
                          onPressed: () async {
                            if (emailidcontroller.text == "" ||
                                passwordcontroller.text == "") {
                              SnackBar profilesnack = SnackBar(
                                  content: Text(
                                      'Username or password cant\'t be empty.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(profilesnack);
                            } else {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailidcontroller.text,
                                        password: passwordcontroller.text);
                                var prefs =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  prefs.setString('loggedinusername',
                                      emailidcontroller.text);
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                );
                                SnackBar profilesnack = SnackBar(
                                  content: Text(
                                      'successfully signed in'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(profilesnack);
                              } on FirebaseAuthException catch (e) {
                                String message = '';
                                if (e.code == 'user-not-found') {
                                  message =
                                      'Account doesn\'t exist with this username.';
                                } else if (e.code == 'wrong-password') {
                                  message = 'Incorrect Password';
                                } else {
                                  message =
                                      'An error occurred. Please check your credentials.';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              }
                            }
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Text(' or continue with '),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            'lib/images/google.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            'lib/images/facebook.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signuppage()),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }

  Future loaduser() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      data.loggedinusername = prefs.getString('loggedinusername') ?? "";
    });
  }
}
