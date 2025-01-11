import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              controller: usernamecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Username'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Bio'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: emailidcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Email id'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              controller: dobcontroller,
              decoration: InputDecoration(
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
                child: Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: () async {
                        if (emailidcontroller.text == "" ||
                            passwordcontroller.text == "") {
                          SnackBar profilesnack = SnackBar(
                              content:
                                  Text('Email id or password cant\'t be empty.'));
                          ScaffoldMessenger.of(context).showSnackBar(profilesnack);
                        } else {
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailidcontroller.text,
                              password: passwordcontroller.text,
                            );
                            var signupid;
                            setState(() {
                              signupid=emailidcontroller.text;
                              data.loggedinusername=emailidcontroller.text;
                            });
                            final docuser = FirebaseFirestore.instance
                                .collection(signupid)
                                .doc('userdetails');
                            await docuser.set({
                              'fullname': fullnamecontroller.text ?? '...',
                              'emailid': emailidcontroller.text ?? '...',
                              'bio': biocontroller.text ?? '...',
                              'dob': dobcontroller.text ?? '...',
                              'url': imgurlcontroller.text ?? '...',
                            });
                            Navigator.pop(context);
                            SnackBar profilesnack = SnackBar(
                                content:
                                    Text('Sign up successful,you can login now.'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(profilesnack);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              SnackBar profilesnack = SnackBar(
                                  content:
                                      Text('The password provided is too weak.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(profilesnack);
                            } else if (e.code == 'email-already-in-use') {
                              SnackBar profilesnack = SnackBar(
                                  content: Text('Account already exists.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(profilesnack);
                            }
                          } catch (e) {
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
                  }
                ),
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
