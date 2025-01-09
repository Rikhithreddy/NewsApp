import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  var namecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var urlcontroller = TextEditingController();
  var name;
  var bio;
  var url;
  var edit;
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 229, 236, 98),
        actions: [
          IconButton(
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              setState(() {
                pref.setBool('edit', true);
                edit = true;
              });
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              var logoutpref = await SharedPreferences.getInstance();
              logoutpref.setBool('edit', true);
              logoutpref.setString('name', '');
              logoutpref.setString('bio', '');
              logoutpref.setString('url', '');
              setState(() {
                edit = true;
                name = '';
                bio = '';
                url = '';
                namecontroller.clear();
                biocontroller.clear();
                urlcontroller.clear();
              });
            },
            icon: Icon(Icons.logout),
          )
        ],
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
                child: url == null
                    ? Image.asset('lib/images/profile.png')
                    : Image.network(
                        "$url",
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('lib/images/profile.png');
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Display the image when fully loaded
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
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
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
                                hintText: 'Bio',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: urlcontroller,
                            decoration: InputDecoration(
                                hintText: 'Image Url',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 170,
                            height: 40,
                            child: Builder(builder: (context) {
                              return ElevatedButton(
                                  onPressed: () async {
                                    if (namecontroller.text == '') {
                                      SnackBar profilesnack = SnackBar(
                                          content:
                                              Text('Name can\'t be empty.'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(profilesnack);
                                    } else if (biocontroller.text == '') {
                                      SnackBar profilesnack = SnackBar(
                                          content:
                                              Text('Bio can\'t be empty.'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(profilesnack);
                                    } else {
                                      var prefers =
                                          await SharedPreferences.getInstance();
                                      await prefers.setBool('edit', false);
                                      await prefers.setString(
                                          'name', namecontroller.text);
                                      await prefers.setString(
                                          'bio', biocontroller.text);
                                      await prefers.setString(
                                          'url', urlcontroller.text);
                                      setState(() {
                                        edit = false;
                                        name = namecontroller.text;
                                        bio = biocontroller.text;
                                        url = urlcontroller.text;
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Save Changes',
                                    style: TextStyle(fontSize: 16),
                                  ));
                            }),
                          ),
                        )
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
                            'Name: $name',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Bio: $bio',
                            style: TextStyle(fontSize: 18),
                          ),
                        ]),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> loaddata() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      bio = prefs.getString('bio');
      url = prefs.getString('url');
      edit = prefs.getBool('edit') ?? true;
    });
  }
}
