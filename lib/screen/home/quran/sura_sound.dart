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
            toolbarHeight: 100,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: MyConstant.kWhite)),
            centerTitle: true,
            title:
                Text(widget.name, style: TextStyle(fontFamily: 'uthmanic',color: MyConstant.kWhite)),
            backgroundColor: MyConstant.kPrimary),
        body: Container(
          color: MyConstant.kWhite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyConstant.kPrimary,
                        ),
                        borderRadius: BorderRadius.circular(15.w)),
                    child: Center(
                        child:
                            Text('${widget.name} \n الشيخ أحمد بن علي العجمي ',
                                style: TextStyle(fontFamily: 'uthmanic',
                                  fontSize: 18.sp,
                                  color: MyConstant.kBlack,
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
                          activeColor: MyConstant.kPrimary,
                          inactiveColor:
                              MyConstant.kPrimary.withOpacity(0.4),
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
                                style: TextStyle(fontFamily: 'uthmanic',color: MyConstant.kBlack),
                              ),
                              Text(
                                '${duration - position}'.substring(
                                    0, position.toString().indexOf('.') + 0),
                                style: TextStyle(fontFamily: 'uthmanic',color: MyConstant.kBlack),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: MyConstant.kPrimary,
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
                              color: MyConstant.kWhite),
                        ),
                      ],
                    );
                  },
                  onLoading: (snapshot) {
                    return Column(
                      children: [
                        LinearProgressIndicator(
                          value: snapshot.progress,
                          color: MyConstant.kPrimary,
                        ),
                        Text(
                          '${snapshot.progress.toString().substring(2, 4)} '
                          '%',
                          style: TextStyle(fontFamily: 'uthmanic',color: MyConstant.kBlack),
                        ),
                        Text(
                          'سيتم تحميل السورة لأول مرة فقط',
                          style: TextStyle(fontFamily: 'uthmanic',
                            color: MyConstant.kBlack,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  },
                  onError: (snapshot) => Text(
                    'يوجد خطا ما, الرجاء التاكد من وجود الانترنت',
                    style: TextStyle(fontFamily: 'uthmanic',color: MyConstant.kBlack),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
