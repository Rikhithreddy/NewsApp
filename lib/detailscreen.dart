import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/data.dart';
import 'package:newsapp/savedpage.dart';

class detailscreen extends StatefulWidget {
  final int index;
  detailscreen({required this.index});

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 229, 236, 98),
        actions: [
          IconButton(
              onPressed: () async {
                final docuser = FirebaseFirestore.instance
                    .collection(data.loggedinusername)
                    .doc('saved articles');
                DocumentSnapshot docSnapshot = await docuser.get();
                if (docSnapshot.exists) {
                  bool articleExists = false;
                  List existingArticles = docSnapshot.get('articles') ?? [];
                  for (int i = 0; i < existingArticles.length; i++) {
                    if (existingArticles[i]['title'] ==
                        data.articles[widget.index]['title']) {
                      setState(() {
                        articleExists = true;
                      });
                      break;
                    }
                  }
                  if (articleExists == false) {
                    existingArticles.add(data.articles[widget.index]);
                    await docuser.update({
                      'articles': existingArticles,
                    });
                    SnackBar profilesnack =
                        SnackBar(content: Text('saved successfully'));
                    ScaffoldMessenger.of(context).showSnackBar(profilesnack);
                  } else {
                    SnackBar profilesnack =
                        SnackBar(content: Text('Already saved'));
                    ScaffoldMessenger.of(context).showSnackBar(profilesnack);
                  }
                } else {
                  await docuser.set({
                    'articles': [data.articles[widget.index]],
                  });
                }
              },
              icon: Icon(Icons.save_alt))
        ],
        title: Center(
          child: Text(
            'NewsApp',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          final docuser = FirebaseFirestore.instance
              .collection(data.loggedinusername)
              .doc('saved articles');
          DocumentSnapshot docSnapshot = await docuser.get();

          if (docSnapshot.exists) {
            bool articleExists = false;
            List existingArticles = docSnapshot.get('articles') ?? [];
            for (int i = 0; i < existingArticles.length; i++) {
              if (existingArticles[i]['title'] ==
                  data.articles[widget.index]['title']) {
                setState(() {
                  articleExists = true;
                });
                existingArticles.removeAt(i);
                await docuser.update({
                  'articles': existingArticles,
                });

                SnackBar profilesnack = SnackBar(
                  content: Text('Deleted successfully'),
                );
                ScaffoldMessenger.of(context).showSnackBar(profilesnack);
                break;
              }
            }

            if (!articleExists) {
              SnackBar profilesnack = SnackBar(
                content: Text('Already deleted or not saved'),
              );
              ScaffoldMessenger.of(context).showSnackBar(profilesnack);
            }
          } else {
            SnackBar profilesnack = SnackBar(
              content: Text('No saved articles found'),
            );
            ScaffoldMessenger.of(context).showSnackBar(profilesnack);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 210, 210),
              borderRadius: BorderRadius.circular(10)),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 200,
                        child: Image.network(
                          data.articles[widget.index]['urlToImage'],
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
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        data.articles[widget.index]['source']['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 229, 241, 62),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text(
                  data.articles[widget.index]['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  'Content:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
                child: Text(
                  data.articles[widget.index]['content'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 20),
                child: Text(
                  data.articles[widget.index]['description'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  'Url for more details:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 20),
                child: Text(
                  data.articles[widget.index]['url'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.articles[widget.index]['author'].toString().length >
                              15
                          ? data.articles[widget.index]['author']
                              .toString()
                              .substring(0, 15)
                          : data.articles[widget.index]['author'].toString(),
                    ),
                    Text(
                      data.articles[widget.index]['publishedAt']
                          .toString()
                          .substring(0, 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class saveddetailscreen extends StatefulWidget {
  final int index;
  saveddetailscreen({required this.index});

  @override
  State<saveddetailscreen> createState() => _saveddetailscreenState();
}

class _saveddetailscreenState extends State<saveddetailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async{
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 229, 236, 98),
        actions: [
          IconButton(
              onPressed: () async {
                final docuser = FirebaseFirestore.instance
              .collection(data.loggedinusername)
              .doc('saved articles');
          DocumentSnapshot docSnapshot = await docuser.get();

          if (docSnapshot.exists) {
            bool articleExists = false;
            List existingArticles = docSnapshot.get('articles') ?? [];
            for (int i = 0; i < existingArticles.length; i++) {
              if (existingArticles[i]['title'] ==
                  data.savedarticles[widget.index]['title']) {
                setState(() {
                  articleExists = true;
                });
                existingArticles.removeAt(i);
                await docuser.update({
                  'articles': existingArticles,
                });

                SnackBar profilesnack = SnackBar(
                  content: Text('Deleted successfully'),
                );
                ScaffoldMessenger.of(context).showSnackBar(profilesnack);
                break;
              }
            }

            if (!articleExists) {
              SnackBar profilesnack = SnackBar(
                content: Text('Already deleted or not saved'),
              );
              ScaffoldMessenger.of(context).showSnackBar(profilesnack);
            }
          } else {
            SnackBar profilesnack = SnackBar(
              content: Text('No saved articles found'),
            );
            ScaffoldMessenger.of(context).showSnackBar(profilesnack);
          }
              },
              icon: Icon(Icons.delete))
        ],
        title: Center(
          child: Text(
            'NewsApp',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 210, 210),
              borderRadius: BorderRadius.circular(10)),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: 200,
                        child: Image.network(
                          data.savedarticles[widget.index]['urlToImage'],
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
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        data.savedarticles[widget.index]['source']['name'],
                        style: TextStyle(
                          color: const Color.fromARGB(255, 229, 241, 62),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text(
                  data.savedarticles[widget.index]['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  'Content:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
                child: Text(
                  data.savedarticles[widget.index]['content'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 20),
                child: Text(
                  data.savedarticles[widget.index]['description'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  'Url for more details:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 20),
                child: Text(
                  data.savedarticles[widget.index]['url'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.savedarticles[widget.index]['author'].toString().length >
                              15
                          ? data.savedarticles[widget.index]['author']
                              .toString()
                              .substring(0, 15)
                          : data.savedarticles[widget.index]['author'].toString(),
                    ),
                    Text(
                      data.savedarticles[widget.index]['publishedAt']
                          .toString()
                          .substring(0, 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
