import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trend_music_demo/drawer_contents.dart';
import 'package:trend_music_demo/providers/music_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "T r e m u",
          style: GoogleFonts.workbench(textStyle: TextStyle(fontSize: 40)),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(child: DrawerContents()),

      body: SafeArea(
        child: Column(
          children: [
            // media player
            GlossyContainer(
              padding: EdgeInsets.only(top: 3),
              opacity: 0.3,
              borderRadius: BorderRadius.circular(20),
              height: 53,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Text(
                        "music name 1234 asd;akskdkakskd;kakd;a",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // play/pause button
                  IconButton(
                    onPressed: Provider.of<MusicProvider>(
                      context,
                    ).togglePlayPause,

                    icon: Provider.of<MusicProvider>(context).isPlaying
                        ? Icon(Icons.pause_circle_filled_rounded)
                        : Icon(Icons.play_circle_filled_rounded),
                    iconSize: 50,
                    padding: EdgeInsets.only(bottom: 10),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.skip_next_rounded),
                    iconSize: 50,
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  Spacer(),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.download_rounded),
                    iconSize: 35,
                  ),

                  IconButton(
                    onPressed: Provider.of<MusicProvider>(context).toggleLike,
                    icon: Provider.of<MusicProvider>(context).isLiked
                        ? Icon(Icons.favorite_rounded)
                        : Icon(Icons.favorite_outline_rounded),
                    color: Provider.of<MusicProvider>(context).isLiked
                        ? Colors.redAccent.shade400
                        : null,

                    iconSize: 35,
                    padding: EdgeInsets.only(bottom: 2),
                  ),
                ],
              ),
            ),

            // top widgets
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

                  SizedBox(width: 7),
                  Expanded(
                    flex: 3,
                    child: GlossyContainer(
                      height: 300,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                        child: Text(
                          "trended musics",
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
                ],
              ),
            ),

            Divider(endIndent: 100, indent: 100),

            // bottom widgets
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
