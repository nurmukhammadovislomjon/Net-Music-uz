// ignore_for_file: file_names, unnecessary_null_comparison, deprecated_member_use, unnecessary_overrides

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_music_uz/colors.dart';

class OpenAudioPage extends StatefulWidget {
  const OpenAudioPage(
      {super.key,
      required this.audios,
      required this.images,
      required this.imagesName,
      required this.index,
      required this.artistName});
  final List<String> audios;
  final List<String> images;
  final List<String> imagesName;
  final String artistName;
  final int index;

  @override
  State<OpenAudioPage> createState() => _OpenAudioPageState();
}

class _OpenAudioPageState extends State<OpenAudioPage>
    with TickerProviderStateMixin {
  AudioPlayer player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  late int currentIndex;
  late AnimationController _animationController;
  late AnimationController _animationControllerRotation;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      if (mounted) {
        setState(() {});
      }
    });
    player.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      if (mounted) {
        setState(() {});
      }
    });

    player.onPositionChanged.listen((newPosition) {
      position = newPosition;
      if (mounted) {
        setState(() {});
      }
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationControllerRotation =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = CurvedAnimation(
        curve: Curves.easeIn, parent: _animationControllerRotation);
    _animationControllerRotation.repeat();
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   _animationControllerRotation.dispose();
  //   player.stop();
  //   if (mounted) {
  //     super.dispose();
  //   }
  // }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerRotation.dispose();
    playerDispose();
    if (mounted) {
      super.dispose();
    }
  }

  Future playerDispose() async {
    await player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RotationTransition(
                turns: animation,
                child: Container(
                  width: size.width * 0.7,
                  height: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: greyColor,
                        blurRadius: 110,
                        blurStyle: BlurStyle.normal,
                      )
                    ],
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: ClipOval(
                    child: Image.network(
                      // width: size.width * 0.7,
                      widget.images[currentIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.imagesName[currentIndex].split('.')[0],
                style: GoogleFonts.akatab(
                  color: blueAccentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.artistName,
                style: GoogleFonts.akatab(
                  color: blueAccentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        player.seek(position);
                        player.resume();
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formatTime(position.inSeconds),
                            style: GoogleFonts.akatab(
                                color: blueAccentColor, fontSize: 18),
                          ),
                          Text(
                            formatTime((duration - position).inSeconds),
                            style: GoogleFonts.akatab(
                                color: blueAccentColor, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: greyColor.withOpacity(0.2),
                          blurRadius: 50,
                          offset: const Offset(2, 2),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          final position1 =
                              Duration(seconds: position.inSeconds - 15);
                          player.seek(position1);
                          position = position1;
                          if (isPlaying == true) {
                            player.resume();
                          } else {
                            player.pause();
                          }
                          setState(() {});
                        },
                        child: Icon(
                          Icons.restore_sharp,
                          size: size.width * 0.07,
                          color: blueAccentColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: greyColor.withOpacity(0.2),
                          blurRadius: 50,
                          offset: const Offset(2, 2),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          player.stop();
                          position = Duration.zero;
                          duration = Duration.zero;
                          _animationController.reverse();
                          if (currentIndex > 0 &&
                              widget.audios[currentIndex - 1] != null) {
                            currentIndex--;
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.skip_previous,
                          size: size.width * 0.07,
                          color: blueAccentColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: greyColor.withOpacity(0.2),
                            blurRadius: 50,
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          if (isPlaying == false) {
                            player.play(UrlSource(widget.audios[currentIndex]));
                            _animationController.forward();
                            isPlaying = true;
                          } else {
                            player.pause();
                            _animationController.reverse();
                            isPlaying = false;
                          }
                        },
                        child: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          size: size.width * 0.1,
                          color: blueAccentColor,
                          progress: _animationController,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: greyColor.withOpacity(0.2),
                          blurRadius: 50,
                          offset: const Offset(2, 2),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          player.stop();
                          position = Duration.zero;
                          duration = Duration.zero;
                          _animationController.reverse();

                          if (currentIndex < widget.audios.length - 1 &&
                              widget.audios[currentIndex + 1] != null) {
                            currentIndex++;
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.skip_next,
                          size: size.width * 0.07,
                          color: blueAccentColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: greyColor.withOpacity(0.2),
                          blurRadius: 50,
                          offset: const Offset(2, 2),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          final position1 =
                              Duration(seconds: position.inSeconds + 15);
                          player.seek(position1);
                          position = position1;
                          if (isPlaying == true) {
                            player.resume();
                          } else {
                            player.pause();
                          }
                          setState(() {});
                        },
                        child: Icon(
                          Icons.update_sharp,
                          size: size.width * 0.07,
                          color: blueAccentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
