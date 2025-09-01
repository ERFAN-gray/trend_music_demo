import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:glossy/glossy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trend_music_demo/models/drawer_contents.dart';
import 'package:trend_music_demo/models/music.dart';
import 'package:trend_music_demo/providers/music_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioPlayer _audioPlayer;
  late Future<List<Music>> _musicListFuture;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _musicListFuture = Provider.of<MusicProvider>(
      context,
      listen: false,
    ).fetchMusicList();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playMusic(Music music) async {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    try {
      await _audioPlayer.setUrl(music.musicUrl);
      await _audioPlayer.play();
      musicProvider.playMusic(music);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error playing audio: $e")));
    }
  }

  Future<void> _handlePlayPause() async {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
      musicProvider.isPlaying = false;
    } else {
      if (musicProvider.currentMusic != null) {
        await _audioPlayer.play();
        musicProvider.isPlaying = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      drawer: Drawer(child: DrawerContents()),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Hero(
          tag: "title",
          child: Text(
            "T r e m u",
            style: GoogleFonts.workbench(
              fontSize: 45,
              color: Color.fromARGB(255, 232, 97, 126),
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: const Color.fromARGB(105, 0, 0, 0),
                  offset: Offset(5, 5),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/musicBack2.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              // media player
              GlossyContainer(
                // image: DecorationImage(
                //   image: AssetImage("assets/gifs/animegirl.gif"),
                // ),
                padding: const EdgeInsets.only(top: 1, left: 3, right: 3),
                borderRadius: BorderRadius.circular(25),
                height: 100,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          musicProvider.currentMusic?.title ?? "Select music",
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
                      icon: musicProvider.isPlaying
                          ? const Icon(Icons.pause_circle_filled_rounded)
                          : const Icon(Icons.play_circle_filled_rounded),
                      iconSize: 50,
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                  ],
                ),
              ),

              const Divider(endIndent: 100, indent: 100),

              // Music list
              Expanded(
                child: GlossyContainer(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  borderRadius: BorderRadius.circular(25),
                  height: double.infinity,
                  width: double.infinity,
                  child: FutureBuilder<List<Music>>(
                    future: _musicListFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No musics found'));
                      }

                      final musics = snapshot.data!;
                      return ListView.builder(
                        itemCount: musics.length,
                        itemBuilder: (context, index) {
                          final music = musics[index];
                          return ListTile(
                            title: Text(music.title),
                            trailing: IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () => _playMusic(music),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
