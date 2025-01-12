import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsapp/loginpage.dart';
import 'package:newsapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  var usernamecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var fullnamecontroller = TextEditingController();
  var emailidcontroller = TextEditingController();
  var dobcontroller = TextEditingController();
  var imgurlcontroller = TextEditingController();
  var biocontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: emailidcontroller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => emailidcontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Email id'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => passwordcontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: fullnamecontroller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => fullnamecontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Full Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: biocontroller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => biocontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Bio'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: dobcontroller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => dobcontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Date of Birth'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: imgurlcontroller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => imgurlcontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Profile Image Url'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 40,
              width: 160,
              child: Center(
                child: Builder(builder: (context) {
                  return TextButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      if (emailidcontroller.text == "" ||
                          passwordcontroller.text == "") {
                        Navigator.pop(context);
                        SnackBar profilesnack = SnackBar(
                            content:
                                Text('Email id or password cant\'t be empty.'));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(profilesnack);
                      } else {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailidcontroller.text,
                            password: passwordcontroller.text,
                          );
                          setState(() {
                            data.loggedinusername = emailidcontroller.text;
                          });
                          final docuser = FirebaseFirestore.instance
                              .collection(data.loggedinusername)
                              .doc('userdetails');
                          await docuser.set({
                            'fullname': fullnamecontroller.text,
                            'emailid': emailidcontroller.text,
                            'bio': biocontroller.text,
                            'dob': dobcontroller.text,
                            'url': imgurlcontroller.text,
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          SnackBar profilesnack = SnackBar(
                              content: Text(
                                  'Sign up successful,you can login now.'));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(profilesnack);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            Navigator.pop(context);
                            SnackBar profilesnack = SnackBar(
                                content:
                                    Text('The password provided is too weak.'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(profilesnack);
                          } else if (e.code == 'email-already-in-use') {
                            Navigator.pop(context);
                            SnackBar profilesnack = SnackBar(
                                content: Text('Account already exists.'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(profilesnack);
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          SnackBar profilesnack = SnackBar(content: Text('$e'));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(profilesnack);
                        }
                      }
                    },
                    child: Text(
                      'Create Account',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? '),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Sign in',
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
}

class signindetails extends StatefulWidget {
  const signindetails({super.key});

  @override
  State<signindetails> createState() => _signindetailsState();
}

class _signindetailsState extends State<signindetails> {
  var fullnamecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var dobcontroller = TextEditingController();
  var imgurlcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
          child: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: fullnamecontroller,
              decoration: InputDecoration(
                  hintText: 'Full Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => fullnamecontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: biocontroller,
              decoration: InputDecoration(
                  hintText: 'Bio',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => biocontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: dobcontroller,
              decoration: InputDecoration(
                  hintText: 'Date of Birth',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => dobcontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: imgurlcontroller,
              decoration: InputDecoration(
                  hintText: 'profile image url',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => imgurlcontroller.clear(),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 40,
              width: 160,
              child: Center(
                child: Builder(builder: (context) {
                  return TextButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      final docuser = FirebaseFirestore.instance
                          .collection(data.loggedinusername)
                          .doc('userdetails');
                      await docuser.set({
                        'fullname': fullnamecontroller.text,
                        'emailid': data.loggedinusername,
                        'bio': biocontroller.text,
                        'dob': dobcontroller.text,
                        'url': imgurlcontroller.text,
                      });
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=>MyApp()),
                      );
                    },
                    child: Text(
                      'save details',
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
                      await FirebaseAuth.instance.signOut();
                      await GoogleSignIn().signOut();
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString('loggedinusername', "");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=>loginpage()),
                      );
                    },
                    child: Text(
                      'sign out',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
