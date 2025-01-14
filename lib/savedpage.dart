import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/data.dart';
import 'package:newsapp/detailscreen.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    data.isloading=true;
    // TODO: implement initState
    super.initState();
    loadsaveddata();
  }

  @override
  Widget build(BuildContext context) {
    return data.isloading==true?Center(child: CircularProgressIndicator()): Expanded(
      child: data.savedarticles.length == 0
          ? Center(
              child: Text('No saved articles.'),
            )
          : ListView.builder(
              itemCount: data.savedarticles.length,
              itemBuilder: (context, index) {
                if (data.savedarticles[index]['author'] == null ||
                    data.savedarticles[index]['source']['name'] == null ||
                    data.savedarticles[index]['title'] == null ||
                    data.savedarticles[index]['description'] == null ||
                    data.savedarticles[index]['url'] == null ||
                    data.savedarticles[index]['urlToImage'] == null ||
                    data.savedarticles[index]['content'] == null ||
                    data.savedarticles[index]['publishedAt'] == null) {
                  return SizedBox.shrink();
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => saveddetailscreen(index: index),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
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
                                      data.savedarticles[index]['urlToImage'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
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
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Text(
                                    data.savedarticles[index]['source']['name'],
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 229, 241, 62),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8),
                            child: Text(
                              data.savedarticles[index]['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data.savedarticles[index]['author']
                                            .toString()
                                            .length >
                                        15
                                    ? data.savedarticles[index]['author']
                                        .toString()
                                        .substring(0, 15)
                                    : data.savedarticles[index]['author']
                                        .toString()),
                                Text(
                                  data.savedarticles[index]['publishedAt']
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
              },
            ),
    );
  }

  Future loadsaveddata() async {
    final docuser = FirebaseFirestore.instance;
    DocumentSnapshot docSnapshot = await docuser.collection(data.loggedinusername).doc('saved articles').get();

    if (docSnapshot.exists) {
      setState(() {
        data.isloading=false;
        data.savedarticles=docSnapshot.get('articles') ?? [];
      });
    }else{
      setState(() {
        data.isloading=false;
        data.savedarticles=[];
      });
    }
  }
}
