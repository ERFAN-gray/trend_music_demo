import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:glossy/glossy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trend_music_demo/models/drawer_contents.dart';
import 'package:trend_music_demo/providers/music_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? songUrl;
  late Future<Map<String, dynamic>> _musicFuture;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _musicFuture = Provider.of<MusicProvider>(
      context,
      listen: false,
    ).fetchMusicsFromServer();

    // Optional: گوش دادن به تغییرات وضعیت پخش
    _audioPlayer.playerStateStream.listen((state) {
      final musicProvider = Provider.of<MusicProvider>(context, listen: false);
      if (state.playing != musicProvider.isPlaying) {
        musicProvider.isPlaying = state.playing;
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _handlePlayPause() async {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
      musicProvider.isPlaying = false;
    } else {
      if (songUrl != null) {
        try {
          await _audioPlayer.setUrl(
            "http://192.168.104.164:3000/download/music/eterna-cancao-wav-12569.mp3",
          ); //songUrl!
          await _audioPlayer.play();
          musicProvider.isPlaying = true;
        } catch (e) {
          print("Error playing audio: $e");
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error playing audio: $e")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("T r e m u", style: GoogleFonts.workbench(fontSize: 40)),
        centerTitle: true,
      ),
      drawer: Drawer(child: DrawerContents()),
      body: SafeArea(
        child: Column(
          children: [
            // media player
            GlossyContainer(
              padding: const EdgeInsets.only(top: 3),
              opacity: 0.3,
              borderRadius: BorderRadius.circular(20),
              height: 53,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "music name here",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // Play/Pause Button
                  IconButton(
                    onPressed: _handlePlayPause,
                    icon: Provider.of<MusicProvider>(context).isPlaying
                        ? const Icon(Icons.pause_circle_filled_rounded)
                        : const Icon(Icons.play_circle_filled_rounded),
                    iconSize: 50,
                    padding: const EdgeInsets.only(bottom: 10),
                  ),

                  // Next button
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next_rounded),
                    iconSize: 50,
                    padding: const EdgeInsets.only(bottom: 10),
                  ),

                  const Spacer(),

                  // Download button
                  IconButton(
                    onPressed: () {
                      if (songUrl != null) {
                        // دانلود آهنگ
                      }
                    },
                    icon: const Icon(Icons.download_rounded),
                    iconSize: 35,
                  ),

                  // Like button
                  IconButton(
                    onPressed: Provider.of<MusicProvider>(
                      context,
                      listen: false,
                    ).toggleLike,
                    icon: Provider.of<MusicProvider>(context).isLiked
                        ? const Icon(Icons.favorite_rounded)
                        : const Icon(Icons.favorite_outline_rounded),
                    color: Provider.of<MusicProvider>(context).isLiked
                        ? Colors.redAccent.shade400
                        : null,
                    iconSize: 35,
                    padding: const EdgeInsets.only(bottom: 2),
                  ),
                ],
              ),
            ),

            // Top widgets
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  SizedBox(
                    child: GlossyContainer(
                      height: 300,
                      width: 175,
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                        child: Text(
                          "video graphy",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(
                              context,
                            ).colorScheme.inversePrimary.withAlpha(130),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),

                  // Music list / API data
                  Expanded(
                    flex: 3,
                    child: GlossyContainer(
                      height: 300,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(15),
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: _musicFuture,
                        builder: (context, snapShot) {
                          if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapShot.hasError) {
                            return Center(
                              child: Text('Error: ${snapShot.error}'),
                            );
                          } else if (snapShot.hasData) {
                            final data = snapShot.data!;
                            final title = data["title"];
                            songUrl = data["musicUrl"];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title ?? "No title",
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          } else {
                            return const Center(child: Text('No data'));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(endIndent: 100, indent: 100),

            // Bottom widgets
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: GlossyContainer(
                  height: double.infinity,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(30),
                  child: Center(
                    child: Text(
                      "music playlist",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(
                          context,
                        ).colorScheme.inversePrimary.withAlpha(130),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
