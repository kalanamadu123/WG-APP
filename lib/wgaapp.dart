import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wga/fullscreen.dart';

class homeOfWga extends StatefulWidget {
  const homeOfWga({Key? key}) : super(key: key);

  @override
  _homeOfWgaState createState() => _homeOfWgaState();
}

class _homeOfWgaState extends State<homeOfWga> {
  List images = [];
  int page = 1;

  void initState() {
    super.initState();
    FetchPexelsApi();
  }

  FetchPexelsApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f917000010000016c985c2dd73f40d49ba1522870a2e08c'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      //print(images[0]);
    });
  }

  LoadMoreImages() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80' + page.toString();
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f917000010000016c985c2dd73f40d49ba1522870a2e08c'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('WG APP'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                //color: Colors.blue,
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreening(
                                        imageurl: images[index]['src']
                                            ['large2x'],
                                      )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    })),
          ),
          InkWell(
            onTap: () {
              LoadMoreImages();
            },
            child: Container(
              height: 70,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                  child: Text(
                "Load More Images",
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
