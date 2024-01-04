import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesListTrailler extends StatelessWidget {
  const MoviesListTrailler(
      {super.key,
      required this.title,
      required this.size,
      required this.items});

  final String title;
  final Size size;
  final List<dynamic> items; // List key ytb

  @override
  Widget build(BuildContext context) {
    var height = size.height;
    return Container(
      height: height * 0.25,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (c, i) {
                return VideoListItem(
                  videoId: items[i]["key"],
                  onTap: () {
                    showDialog(
                      // barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: items[i]["key"]),
                              showVideoProgressIndicator: true,
                              onEnded: (data) {
                                Navigator.pop(
                                    context); // Close the fullscreen dialog when video ends
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitUp,
                                  DeviceOrientation.portraitDown,
                                ]);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String videoId;
  const VideoListItem({super.key, required this.videoId, this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5.0,
        margin: const EdgeInsets.all(10.0),
        child: YoutubePlayer(
          width: 175,
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              disableDragSeek: false,
              loop: true,
              forceHD: false,
              showLiveFullscreenButton: false,
              hideControls: true,
            ),
          ),
          showVideoProgressIndicator: false,
          progressIndicatorColor: Colors.blueAccent,
          progressColors: const ProgressBarColors(
            playedColor: Colors.blue,
            handleColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
