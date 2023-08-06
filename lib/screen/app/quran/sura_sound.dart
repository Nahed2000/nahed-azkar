import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_cache_manager/media_cache_manager.dart';

import '../../../services/constant.dart';

class SuraSound extends StatefulWidget {
  final int index;
  final String name;

  const SuraSound({super.key, required this.index, required this.name});

  @override
  State<SuraSound> createState() => _SuraSoundState();
}

class _SuraSoundState extends State<SuraSound>
    with SingleTickerProviderStateMixin {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  String? index;

  void getIndex() {
    if (widget.index <= 9) {
      index = '00${widget.index}';
    } else if (widget.index >= 9 && widget.index <= 99) {
      index = '0${widget.index}';
    } else {
      index = '${widget.index}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    getIndex();

    //playInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(widget.name),
            backgroundColor: MyConstant.primaryColor),
        body: Container(
          color: MyConstant.myWhite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyConstant.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(15.w)),
                    child: Center(
                        child:
                            Text('${widget.name} \n الشيخ أحمد بن علي العجمي ',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: MyConstant.myBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center))),
                SizedBox(height: 30.h),
                DownloadMediaBuilder(
                  url: 'https://server10.mp3quran.net/ajm/$index.mp3',
                  onSuccess: (snapshot) {
                    Future.delayed(const Duration(microseconds: 100), () {
                      audioPlayer.setSourceDeviceFile(snapshot.filePath!);
                    });
                    return Column(
                      children: [
                        Slider(
                          activeColor: MyConstant.primaryColor,
                          inactiveColor:
                              MyConstant.primaryColor.withOpacity(0.4),
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(),
                          onChanged: (val) async {
                            final position = Duration(seconds: val.toInt());
                            await audioPlayer.seek(position);
                            await audioPlayer.resume();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                position.toString().substring(
                                    0, position.toString().indexOf('.') + 0),
                                style: TextStyle(color: MyConstant.myBlack),
                              ),
                              Text(
                                '${duration - position}'.substring(
                                    0, position.toString().indexOf('.') + 0),
                                style: TextStyle(color: MyConstant.myBlack),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: MyConstant.primaryColor,
                          child: IconButton(
                              onPressed: () async {
                                if (isPlaying) {
                                  await audioPlayer.pause();
                                } else {
                                  await audioPlayer.resume();
                                }
                              },
                              icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow),
                              iconSize: 50,
                              color: MyConstant.myWhite),
                        ),
                      ],
                    );
                  },
                  onLoading: (snapshot) {
                    return Column(
                      children: [
                        LinearProgressIndicator(
                          value: snapshot.progress,
                          color: MyConstant.primaryColor,
                        ),
                        Text(
                          '${snapshot.progress.toString().substring(2, 4)} '
                          '%',
                          style: TextStyle(color: MyConstant.myBlack),
                        ),
                        Text(
                          'سيتم تحميل السورة لأول مرة فقط',
                          style: TextStyle(
                            color: MyConstant.myBlack,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  },
                  onError: (snapshot) => Text(
                    'يوجد خطا ما, الرجاء التاكد من وجود الانترنت',
                    style: TextStyle(color: MyConstant.myBlack),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
