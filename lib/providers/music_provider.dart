import 'package:flutter/widgets.dart';

class MusicProvider with ChangeNotifier {
  bool _isPlaying = false;
  bool _isLiked = false;

  bool get isPlaying => _isPlaying;
  bool get isLiked => _isLiked;

  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  set isLiked(bool value) {
    _isLiked = value;
    notifyListeners();
  }

  void togglePlayPause() {
    isPlaying = !isPlaying;
  }

  void toggleLike() {
    isLiked = !isLiked;
    notifyListeners();
  }
}
