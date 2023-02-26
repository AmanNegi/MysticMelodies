import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mysticmelodies/data/audio_helper.dart';
import 'package:mysticmelodies/globals.dart';
import 'package:mysticmelodies/models/item_model.dart';
import 'package:mysticmelodies/models/song_item.dart';

class SongPage extends StatefulHookWidget {
  final int index;
  final ItemModel item;
  const SongPage({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late SongItem song;
  @override
  void initState() {
    song = widget.item.songs[widget.index];
    super.initState();
    load(song, widget.item);
  }

  @override
  Widget build(BuildContext context) {
    AnimationController controller =
        useAnimationController(duration: const Duration(seconds: 10));
    controller.repeat();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            // await disposeAudioPlayer();
            Navigator.pop(context);
          },
        ),
        backgroundColor: darkColor,
        title: const Text("Now Playing"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.item.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black54,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          _getRotatingImage(controller),
          Positioned(
            top: 0.1 * getHeight(context),
            left: 15,
            right: 15.0,
            child: SizedBox(
              child: Column(
                children: [
                  Text(
                    song.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      // fontFamily: "Gloock",
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text("~ ${song.singer}"),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.6 * getHeight(context),
            left: 10.0,
            right: 10.0,
            child: StreamBuilder(
              stream: assetsAudioPlayer.currentPosition,
              builder: (context, asyncSnapshot) {
                final Duration currentDuration =
                    asyncSnapshot.data ?? const Duration(seconds: 0);
                Duration totalDuration;
                try {
                  totalDuration =
                      assetsAudioPlayer.current.value!.audio.duration;
                } catch (e) {
                  debugPrint("Going For Fallback Duration");
                  totalDuration = const Duration(seconds: 1);
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(_printDuration(currentDuration)),
                          const Spacer(),
                          Text(_printDuration(totalDuration)),
                        ],
                      ),
                    ),
                    Slider(
                      inactiveColor: darkColor,
                      onChanged: (newChange) {
                        var duration =
                            Duration(milliseconds: newChange.toInt());
                        print("New Change $duration");
                        seekAt(duration);
                      },
                      value: currentDuration.inMilliseconds * 1.0,
                      min: 0.0,
                      max: totalDuration.inMilliseconds * 1.0,
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 0.7 * getHeight(context),
            left: 15,
            right: 15.0,
            child: SizedBox(
              // color: Colors.green,
              height: 0.1 * getHeight(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.skip_previous_rounded),
                  ),
                  StreamBuilder(
                      stream: assetsAudioPlayer.isPlaying,
                      builder: (context, snapshot) {
                        bool isPlaying = snapshot.data ?? false;
                        return GestureDetector(
                          onTap: () {
                            playOrPause();
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: darkColor,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 50,
                                child: Icon(
                                  isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.skip_next_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center _getRotatingImage(AnimationController controller) {
    return Center(
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return RotationTransition(
              turns: controller,
              child: CircleAvatar(
                backgroundColor: semiDarkColor,
                radius: 100,
                child: CircleAvatar(
                  radius: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image.asset(
                      "assets/music.png",
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
