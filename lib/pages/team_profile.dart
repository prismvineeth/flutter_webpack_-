import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ng_companion/api/profile_model.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player_web/video_player_web.dart';

class TeamProfile extends StatefulWidget {
  Profile profile;
  TeamProfile({
    super.key,
    required this.profile,
  });

  @override
  State<TeamProfile> createState() => _TeamProfileState();
}

class _TeamProfileState extends State<TeamProfile> {
  late VideoPlayerController _videocontroller;

  bool isMusicOn = true;

  @override
  void initState() {
    super.initState();
    _videocontroller = VideoPlayerController.network(
      widget.profile.videourl,
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );
//     _videocontroller = VideoPlayerController.network(
//   String dataSource, {
//   VideoFormat? formatHint,
//   Future<ClosedCaptionFile>? closedCaptionFile,
//   VideoPlayerOptions? videoPlayerOptions,
//   Map<String, String> httpHeaders = const <String, String>{},
// })

    _videocontroller.addListener(() {
      setState(() {});
    });
    _videocontroller.setLooping(false);
    _videocontroller.initialize().then((_) => setState(() {}));
    // _videocontroller.setVolume(0.0);
    _videocontroller.pause();
  }

  @override
  void dispose() {
    _videocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple.shade300,
            ),
            title: Text(widget.profile.name),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: VisibilityDetector(
              key: Key(widget.profile.id),
              onVisibilityChanged: (visibilityInfo) async {
                if (!kIsWeb) {
                  if (_videocontroller != null &&
                      _videocontroller.value.isInitialized) {
                    final visibleFraction = visibilityInfo.visibleFraction;
                    if (visibleFraction == 1.0) {
                      if (!_videocontroller.value.isPlaying) {
                        await _videocontroller.play();

                        // print('TV FEED $_feedID $_isFeedViewed');
                      }
                    } else if (visibleFraction == 0.0) {
                      if (_videocontroller.value.isPlaying) {
                        _videocontroller.pause();
                      }
                    }
                  }
                }
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _videocontroller.value.aspectRatio,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_videocontroller.value.isPlaying) {
                                      _videocontroller.pause();
                                    } else {
                                      _videocontroller.play();
                                    }
                                  });
                                },
                                child: VideoPlayer(_videocontroller))),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: VideoProgressIndicator(
                              _videocontroller, //controller
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.blue,
                                bufferedColor: Colors.red,
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (isMusicOn) {
                                _videocontroller.setVolume(0.0);
                                isMusicOn = false;
                                setState(() {});
                              } else {
                                _videocontroller.setVolume(1.0);
                                isMusicOn = true;
                                setState(() {});
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Icon(
                                  size: 15,
                                  isMusicOn == true
                                      ? Icons.volume_up
                                      : Icons.volume_off,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _videocontroller.value.isPlaying
                              ? _videocontroller.pause()
                              : _videocontroller.play();
                        });
                      },
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: _videocontroller.value.isPlaying == true
                            ? const Icon(
                                Icons.pause,
                                size: 30,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.blue,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // InkWell(
            //   onTap: () {
            //     if (controller.value.isPlaying) {
            //       controller.pause();
            //     } else {
            //       controller.play();
            //     }
            //   },
            //   child: AspectRatio(
            //     aspectRatio: controller.value.aspectRatio,
            //     child: ClipRRect(
            //         borderRadius: BorderRadius.circular(8),
            //         child: VideoPlayer(controller)),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
