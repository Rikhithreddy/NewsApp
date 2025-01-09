import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/data.dart';
import 'package:newsapp/detailscreen.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  String apiKey = '092843a569dd4a2d83023322cb161b5e';
  var currentcategory = 'General';
  @override
  void initState() {
    super.initState();
    data.isloading=true;
    fetchnews('everything?q', 'general');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(47, 232, 172, 116),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 12, 5, 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentcategory == 'General'
                          ? const Color.fromARGB(255, 193, 234, 9)
                          : const Color.fromARGB(255, 209, 215, 215),
                    ),
                    onPressed: () {
                      setState(() {
                        currentcategory = 'General';
                        data.isloading=true;
                        fetchnews('everything?q', 'general');
                      });
                    },
                    child: Text(
                      'General',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentcategory == 'Business'
                          ? const Color.fromARGB(255, 193, 234, 9)
                          : const Color.fromARGB(255, 209, 215, 215),
                    ),
                    onPressed: () {
                      setState(() {
                        currentcategory = 'Business';
                        data.isloading=true;
                        fetchnews('everything?q', 'bitcoin');
                      });
                    },
                    child: Text(
                      'Business',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentcategory == 'Technology'
                          ? const Color.fromARGB(255, 193, 234, 9)
                          : const Color.fromARGB(255, 209, 215, 215),
                    ),
                    onPressed: () {
                      currentcategory = 'Technology';
                      setState(() {
                        data.isloading=true;
                        fetchnews('top-headlines?category', 'technology');
                      });
                    },
                    child: Text(
                      'Technology',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentcategory == 'Cinema'
                          ? const Color.fromARGB(255, 193, 234, 9)
                          : const Color.fromARGB(255, 209, 215, 215),
                    ),
                    onPressed: () {
                      currentcategory = 'Cinema';
                      setState(() {
                        data.isloading=true;
                        fetchnews('top-headlines?category', 'entertainment');
                      });
                    },
                    child: Text(
                      'Cinema',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentcategory == 'Sports'
                          ? const Color.fromARGB(255, 193, 234, 9)
                          : const Color.fromARGB(255, 209, 215, 215),
                    ),
                    onPressed: () {
                      currentcategory = 'Sports';
                      setState(() {
                        data.isloading=true;
                        fetchnews('top-headlines?category', 'sports');
                      });
                    },
                    child: Text(
                      'Sports',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 12, 15, 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentcategory == 'Health'
                          ? const Color.fromARGB(255, 193, 234, 9)
                          : const Color.fromARGB(255, 209, 215, 215),
                    ),
                    onPressed: () {
                      currentcategory = 'Health';
                      setState(() {
                        data.isloading=true;
                        fetchnews('everything?q', 'health');
                      });
                    },
                    child: Text(
                      'Health',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        data.isloading?Center(child: CircularProgressIndicator()): Expanded(
          child: ListView.builder(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                    color:
                                        const Color.fromARGB(255, 229, 241, 62),
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
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data.articles[index]['author']
                                          .toString()
                                          .length >
                                      15
                                  ? data.articles[index]['author']
                                      .toString()
                                      .substring(0, 15)+'...'
                                  : data.articles[index]['author'].toString(),
                                  overflow: TextOverflow.ellipsis,),
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
        ),
      ],
    );
  }

  Future<void> fetchnews(String endpoint, String category) async {
    final int pagesize = 100;
    int page = 1;
    final String url =
        'https://newsapi.org/v2/$endpoint=$category&pageSize=$pagesize&page=$page&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      setState(() {
        data.articles = json['articles'];
        data.isloading=false;
      });
    } catch (e) {
      print(e);
    }
  }
}
