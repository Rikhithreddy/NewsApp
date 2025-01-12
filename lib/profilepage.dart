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
    data.isloading = true;
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
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
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
                            Navigator.pop(context);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => loginpage()),
                              (route) => false,
                            );
                            SnackBar profilesnack = SnackBar(
                                content: Text('Data deleted successfully.'));
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
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pop();
                            var prefs = await SharedPreferences.getInstance();
                            setState(() {
                              prefs.setString('loggedinusername', "");
                            });
                            Navigator.pop(context);
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
        tooltip: 'edit',
        backgroundColor: const Color.fromARGB(255, 226, 214, 38),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: const Color.fromARGB(255, 137, 133, 133), width: 2)),
        child: Icon(Icons.edit),
        onPressed: () {
          setState(() {
            edit = true;
            fullnamecontroller.text = fullname;
            emailidcontroller.text = emailid;
            biocontroller.text = bio;
            imageurlcontroller.text = imageurl;
            dobcontroller.text = dob;
          });
        },
      ),
      backgroundColor: const Color.fromARGB(255, 196, 197, 196),
      body: data.isloading == true
          ? Center(child: CircularProgressIndicator())
          : Center(
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
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextField(
                                  controller: fullnamecontroller,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () =>
                                            fullnamecontroller.clear(),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextField(
                                  controller: biocontroller,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () => biocontroller.clear(),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextField(
                                  controller: emailidcontroller,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () =>
                                            emailidcontroller.clear(),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextField(
                                  controller: dobcontroller,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () => dobcontroller.clear(),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextField(
                                  controller: imageurlcontroller,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () =>
                                            imageurlcontroller.clear(),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
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
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );
                                        final docuser = FirebaseFirestore
                                            .instance
                                            .collection(data.loggedinusername)
                                            .doc('userdetails');
                                        await docuser.update({
                                          'fullname':
                                              fullnamecontroller.text == ''
                                                  ? fullname
                                                  : fullnamecontroller.text,
                                          'emailid':
                                              emailidcontroller.text == ''
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
                                          Navigator.pop(context);
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
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Full Name:',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '$fullname',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Bio:',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '$bio',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Email id:',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '$emailid',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'DoB:',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '$dob',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ]),
                          ),
                        )
                ],
              ),
            ),
    );
  }

  Future loaddata() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      data.loggedinusername = prefs.getString('loggedinusername') ?? "";
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
        data.isloading = false;
      });
    } else {}
  }
}
