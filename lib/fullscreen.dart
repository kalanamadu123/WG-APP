import 'package:flutter/material.dart';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:wallpaper_manager/wallpaper_manager.dart';

class FullScreening extends StatefulWidget {
  final String imageurl;

  const FullScreening({Key? key, required this.imageurl}) : super(key: key);

  @override
  _FullScreeningState createState() => _FullScreeningState();
}

class _FullScreeningState extends State<FullScreening> {
  // Future<void>setWallpaper() async {
  //   int location = WallpaperManager.HOME_SCREEN;
  //   var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
  //   final String result =
  //       await WallpaperManager.setWallpaperFromFile(file.path,location);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Image.network(widget.imageurl),
            )),
            Container(
              child: InkWell(
                onTap: () {
                 // setWallpaper();
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.black,
                  child: const Center(
                      child: Text(
                    "Set Image",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
