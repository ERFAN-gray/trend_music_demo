import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:trend_music_demo/models/music.dart';
import 'package:http/http.dart' as http;

class MusicProvider with ChangeNotifier {
  // Variables
  bool _isPlaying = false;
  bool _isLiked = false;
  final List<Music> _musicList = [];
  Music? _currentMusic;

  // Getters
  bool get isPlaying => _isPlaying;
  bool get isLiked => _isLiked;
  List<Music> get musicList => _musicList;
  Music? get currentMusic => _currentMusic;

  // Setters
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

  // Add musics to the list
  void setMusicList(List<Music> musicList) {
    _musicList.clear();
    _musicList.addAll(musicList);
    notifyListeners();
  }

  // Toggle play/pause
  void togglePlayPause() {
    isPlaying = !isPlaying;
  }

  // Toggle like
  void toggleLike() {
    isLiked = !isLiked;
  }

  // Play specific music
  void playMusic(Music music) {
    currentMusic = music;
    isPlaying = true;
  }

  // Fetch single music (for test)
  Future<Music> fetchSingleMusic() async {
    final url = Uri.parse(
      "http://192.168.119.164:3000/music/689cae064ee97d109a3f577c",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Music.fromJson(data);
    }
    throw Exception('Failed to load music');
  }

  // Fetch music list
  Future<List<Music>> fetchMusicList() async {
    final url = Uri.parse("http://192.168.119.164:3000/music");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final musics = data.map((e) => Music.fromJson(e)).toList();
      setMusicList(musics);
      return musics;
    }
    throw Exception('Failed to load musics');
  }
}
