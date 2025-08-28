class Music {
  final String id;
  final String title;
  final String musicUrl;

  Music({required this.id, required this.title, required this.musicUrl});

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json["_id"] ?? "",
      title: json["title"] ?? "Unknown",
      musicUrl: json["musicUrl"] ?? "",
    );
  }
}
