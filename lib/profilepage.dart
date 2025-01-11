import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/data.dart';
import 'package:newsapp/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  var fullnamecontroller = TextEditingController();
  var emailidcontroller = TextEditingController();
  var dobcontroller = TextEditingController();
  var imageurlcontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var edit = false;
  var fullname;
  var emailid;
  var dob;
  var imageurl;
  var bio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm deletion?'),
                      content: Text('Are you sure want to delete account'),
                      actions: [
                        TextButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('YES'),
                          onPressed: () async {
                            final collectionRef = FirebaseFirestore.instance
                                .collection(data.loggedinusername);
                            try {
                              var snapshots = await collectionRef.get();
                              for (var doc in snapshots.docs) {
                                await doc.reference.delete();
                              }
                            } catch (e) {
                              print("Error deleting collection: $e");
                            }
                            try {
                              User? user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                await user.delete();
                                print("User account deleted successfully.");
                              } else {
                                print("No user is logged in.");
                              }
                            } catch (e) {
                              print("Error deleting account: $e");
                            }
                            var preffers =
                                await SharedPreferences.getInstance();
                            setState(() {
                              preffers.setString('loggedinusername', "");
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => loginpage()),
                              (route) => false,
                            );
                            SnackBar profilesnack = SnackBar(
                                content: Text('Account deleted successfully.'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(profilesnack);
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm logout?'),
                      content: Text('Are you sure want to logout'),
                      actions: [
                        TextButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('YES'),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pop();
                            var prefs = await SharedPreferences.getInstance();
                            setState(() {
                              prefs.setString('loggedinusername', "");
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => loginpage()),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          setState(() {
            edit = true;
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: Container(
                height: 150,
                width: 150,
                child: imageurl == null
                    ? Image.asset('lib/images/profile.png')
                    : Image.network(
                        "$imageurl",
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('lib/images/profile.png');
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            edit == true
                ? Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: fullnamecontroller,
                            decoration: InputDecoration(
                                hintText: fullname,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: biocontroller,
                            decoration: InputDecoration(
                                hintText: bio,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: emailidcontroller,
                            decoration: InputDecoration(
                                hintText: emailid,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: dobcontroller,
                            decoration: InputDecoration(
                                hintText: dob,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: imageurlcontroller,
                            decoration: InputDecoration(
                                hintText: imageurl,
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 45,
                            width: 140,
                            child: Center(
                              child: TextButton(
                                onPressed: () async {
                                  final docuser = FirebaseFirestore.instance
                                      .collection(data.loggedinusername)
                                      .doc('userdetails');
                                  await docuser.update({
                                    'fullname': fullnamecontroller.text == ''
                                        ? fullname
                                        : fullnamecontroller.text,
                                    'emailid': emailidcontroller.text == ''
                                        ? emailid
                                        : emailidcontroller.text,
                                    'dob': dobcontroller.text == ''
                                        ? dob
                                        : dobcontroller.text,
                                    'bio': biocontroller.text == ''
                                        ? bio
                                        : biocontroller.text,
                                    'url': imageurlcontroller.text == ''
                                        ? imageurl
                                        : imageurlcontroller.text,
                                  });
                                  setState(() {
                                    edit = false;
                                    loaddata();
                                  });
                                },
                                child: Text(
                                  'save changes',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Full Name: $fullname',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Bio: $bio',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Email id: $emailid',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'DoB: $dob',
                            style: TextStyle(fontSize: 18),
                          ),
                        ]),
                  )
          ],
        ),
      ),
    );
  }

  Future loaddata() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      data.loggedinusername = prefs.getString('loggedinusername') ?? "...";
    });
    final docuser = FirebaseFirestore.instance
        .collection(data.loggedinusername)
        .doc('userdetails');
    DocumentSnapshot snapshot = await docuser.get();
    if (snapshot.exists) {
      var datas = snapshot.data() as Map<String, dynamic>;
      setState(() {
        fullname = datas['fullname'];
        emailid = datas['emailid'];
        dob = datas['dob'];
        bio = datas['bio'];
        imageurl = datas['url'];
      });
    } else {}
  }
}
