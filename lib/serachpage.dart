import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/data.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/detailscreen.dart';

class MySearchDelegate extends StatefulWidget {
  MySearchDelegate({super.key});

  @override
  State<MySearchDelegate> createState() => _MySearchDelegateState();
}

class _MySearchDelegateState extends State<MySearchDelegate> {
  var serachbarcontroller = TextEditingController();
  var justopened;
  String apikey = '092843a569dd4a2d83023322cb161b5e';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.articles = [];
    justopened = true;
    data.isloading=false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(16),
        child: TextField(
          controller: serachbarcontroller,
          decoration: InputDecoration(
              hintText: 'search',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue)),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    justopened = false;
                    if (serachbarcontroller.text.length < 3) {
                      SnackBar profilesnack =
                          SnackBar(content: Text('Min 3 characters required'));
                      ScaffoldMessenger.of(context).showSnackBar(profilesnack);
                      setState(() {
                        data.articles = [];
                      });
                    } else {
                      setState(() {
                        data.isloading=true;
                      });
                      await searchdata(
                          'everything?q', serachbarcontroller.text);
                    }
                  },
                ),
              )),
          enabled: true,
        ),
      ),
      data.isloading?Center(child: CircularProgressIndicator()): Expanded(
        child: data.articles.length == 0 && justopened == false
            ? Center(
                child: Text('No data found'),
              )
            : ListView.builder(
                itemCount: data.articles.length,
                itemBuilder: (context, index) {
                  if (data.articles[index]['author'] == null ||
                      data.articles[index]['source']['name'] == null ||
                      data.articles[index]['title'] == null ||
                      data.articles[index]['description'] == null ||
                      data.articles[index]['url'] == null ||
                      data.articles[index]['urlToImage'] == null ||
                      data.articles[index]['content'] == null ||
                      data.articles[index]['publishedAt'] == null) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detailscreen(index: index),
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
                                        data.articles[index]['urlToImage'],
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
                                      data.articles[index]['source']['name'],
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
                            data.articles[index]['title'],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data.articles[index]['author']
                                              .toString()
                                              .length >
                                          15
                                      ? data.articles[index]['author']
                                          .toString()
                                          .substring(0, 15)
                                      : data.articles[index]['author']
                                          .toString()),
                                  Text(
                                    data.articles[index]['publishedAt']
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
      )
    ]);
  }

  Future<void> searchdata(String endpoint, String category) async {
    final int pagesize = 50;
    int page = 1;
    final String url =
        'https://newsapi.org/v2/$endpoint=$category&pageSize=$pagesize&page=$page&apiKey=$apikey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          data.articles = json['articles'];
          data.isloading=false;
        });
      } else {
        setState(() {
          data.articles = [];
          data.isloading=false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
