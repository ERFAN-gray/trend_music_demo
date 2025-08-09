import 'package:flutter/widgets.dart';
import 'package:trend_music_demo/models/music.dart';
import 'package:http/http.dart';

class MusicProvider with ChangeNotifier {
  //variables
  bool _isPlaying = false;
  bool _isLiked = false;
  final List<Music> _musicList = [];
  Music? _currentMusic;

  // getters
  bool get isPlaying => _isPlaying;
  bool get isLiked => _isLiked;
  List<Music> get musicList => _musicList;
  Music? get currentMusic => _currentMusic;

  // seters
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  set isLiked(bool value) {
    _isLiked = value;
    notifyListeners();
  }

  set currentMusic(Music? music) {
    _currentMusic = music;
    notifyListeners();
  }

  // add music to the list
  void setMusiclist(List<Music> musicList) {
    _musicList.addAll(musicList);
    notifyListeners();
  }

  // methods
  void togglePlayPause() {
    isPlaying = !isPlaying;
  }

  void toggleLike() {
    isLiked = !isLiked;
  }

  void playMusic(Music music) {
    currentMusic = music;
    isPlaying = true;
  }

  Future<void> fetchMusicsFromServer() async {
    final url = Uri.parse(
      "https://legal-queens-pay.loca.lt/music/6896f04db92863f3df268a6d",
    );
    final response = await get(url);
    if (response.statusCode == 200) {
      Text(response.body);
      print(response.body);
    }
  }
}
