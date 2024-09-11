import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  SongPage({super.key});

  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = '${duration.inMinutes}:$twoDigitSeconds';

    return formattedTime;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      final playlist = value.playlist;
      final currentSong = playlist[value.currentSongIndex ?? 0];
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back)),
                    Text('P L A Y L I S T'),
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),
                SizedBox(height: 20),
                NeuBox(
                    child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(currentSong.imagePath)),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentSong.songName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(currentSong.artistName),
                            ],
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                  ],
                )),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(value.currentDuration)),
                      Icon(Icons.shuffle),
                      Icon(Icons.repeat),
                      Text(formatTime(value.totalDuration))
                    ],
                  ),
                ),
                SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 5)),
                    child: Slider(
                      min: 0,
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.currentDuration.inSeconds.toDouble(),
                      activeColor: Colors.green,
                      inactiveColor: Theme.of(context).colorScheme.primary,
                      onChanged: (double double) {},
                      onChangeEnd: (double double) {
                        value.seek(Duration(seconds: double.toInt()));
                      },
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child: NeuBox(child: Icon(Icons.skip_previous)))),
                    SizedBox(width: 20),
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                                child: Icon(value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow)))),
                    SizedBox(width: 20),
                    Expanded(
                        child: GestureDetector(
                            onTap: value.playNextSong,
                            child: NeuBox(child: Icon(Icons.skip_next)))),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
