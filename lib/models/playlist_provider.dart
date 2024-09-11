import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: 'Август - это ты',
        artistName: 'МОТ',
        imagePath: 'assets/image/avgust_image.jpg',
        audioPath: 'audio/avgust_audio.mp3'),
    Song(
        songName: 'Daylight',
        artistName: 'David Kushner',
        imagePath: 'assets/image/daylight_image.jpg',
        audioPath: 'audio/daylight_audio.mp3')
  ];

  int? _currentSongIndex;

//A U D I O
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async{
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async{
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async{
    _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async{
    print(isPlaying);
    isPlaying ? pause() : resume();
    notifyListeners();
  }

  void seek(Duration position) async{
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  void playNextSong() async{
    if (_currentSongIndex != null){
      if (_currentSongIndex! < _playlist.length - 1){
        currentSongIndex = _currentSongIndex! + 1;

      }else{
        currentSongIndex = 0;
      }
    }
    notifyListeners();
  }

  void playPreviousSong() async{
    if(_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    else {
      if (_currentSongIndex! > 0){
        currentSongIndex = _currentSongIndex! - 1;
      }else{
        currentSongIndex = _playlist.length - 1;
      }
    }
    notifyListeners();
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
    notifyListeners();
  }

//G E T T E R S

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

//S E T T E R S
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null){
      play();
    }
    notifyListeners();
  }
}
